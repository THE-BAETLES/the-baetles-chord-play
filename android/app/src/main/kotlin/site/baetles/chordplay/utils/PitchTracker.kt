package site.baetles.chordplay

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.res.AssetManager
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.net.ConnectivityManager
import android.os.Build
import android.util.Log
import com.google.firebase.events.EventHandler
import io.flutter.plugin.common.EventChannel
import java.nio.BufferOverflowException
import java.nio.ShortBuffer
import java.util.concurrent.locks.ReentrantLock
import kotlin.concurrent.thread
import org.tensorflow.lite.Interpreter
import java.io.FileInputStream
import java.io.IOException
import java.nio.BufferUnderflowException
import java.nio.ByteBuffer
import java.nio.channels.FileChannel
import android.net.NetworkCapabilities
import android.net.NetworkRequest


class PitchTracker(private var activity: Activity) : EventChannel.StreamHandler {
    // Audio recording setting
    private val audioSource: Int = MediaRecorder.AudioSource.MIC
    private val sampleRate: Int = 16000
    private val recordingLength: Int = 17920
    private val channel: Int = AudioFormat.CHANNEL_IN_MONO
    private val encodingType: Int = AudioFormat.ENCODING_PCM_16BIT

    // Audio recognition setting
    private val ACTUAL_MODEL_FILENAME = "onsets_frames_wavinput.tflite"
    private val minimumTimeBetweenSamplesInMS: Long = 30

    private val logTag: String = "PitchTracker"

    private var audioRecorder: AudioRecord? = null
    private var recordingBuffer = ShortBuffer.allocate(recordingLength)
    private var recordingBufferLock: ReentrantLock = ReentrantLock()
    private var tflInterpreter: Interpreter? = null

    private var recorderThread: Thread? = null
    private var recognitionThread: Thread? = null

    private var shouldContinueRecording = false
    private var shouldContinueRecognition = false

    private var isPlaying: Boolean = false

    // for handling stream
    private var eventSink: EventChannel.EventSink? = null;


    init {
        // prepare Engine
        Log.v(logTag, "Audio Engine Prepare")

        tflInterpreter = try {
            Interpreter(loadModelFile(activity.assets, ACTUAL_MODEL_FILENAME)!!)

        } catch (e: Exception) {
            throw RuntimeException(e)
        }

        tflInterpreter!!.resizeInput(0, intArrayOf(recordingLength, 1))
    }

    fun isPlaying() : Boolean {
        return this.isPlaying;
    }


    @Throws(IOException::class)
    private fun loadModelFile(
        assets: AssetManager,
        modelFilename: String
    ): ByteBuffer? {
        val fileDescriptor = assets.openFd(modelFilename)
        val inputStream = FileInputStream(fileDescriptor.fileDescriptor)
        val fileChannel: FileChannel = inputStream.channel
        val startOffset = fileDescriptor.startOffset
        val declaredLength = fileDescriptor.declaredLength
        return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength)
    }


    fun start() {
        isPlaying = true
        startRecording()
        startRecognition()
    }


    fun stop() {
        isPlaying = false;
        stopRecording()
        stopRecognition()
    }

    fun startRecording() {
        if (recorderThread != null) {
            Log.i(logTag, "startRecording() is called while it is already running")
            return
        }

        shouldContinueRecording = true

        // Start recording data
        recorderThread = thread() {
            record()
        }

        Log.d(logTag, "recorder thread is running!")
    }


    private fun stopRecording() {
        if (recorderThread == null) {
            return
        }

        shouldContinueRecording = false
        recorderThread = null
        Log.d(logTag, "recorder thread is stopped")
    }


    @SuppressLint("MissingPermission")
    private fun record() {
        // Calculate the minimum recording buffer size and create buffer
        var bufferSizeInByte = AudioRecord.getMinBufferSize(
            sampleRate,
            AudioFormat.CHANNEL_IN_MONO,
            AudioFormat.ENCODING_PCM_16BIT
        )

        if (bufferSizeInByte == AudioRecord.ERROR || bufferSizeInByte == AudioRecord.ERROR_BAD_VALUE) {
            bufferSizeInByte = sampleRate * 2
        }

        var inputBuffer: ShortArray = ShortArray(size = bufferSizeInByte / 2);

        // Create AudioRecord object
        audioRecorder = AudioRecord(
            audioSource,
            sampleRate,
            AudioFormat.CHANNEL_IN_MONO,
            AudioFormat.ENCODING_PCM_16BIT,
            bufferSizeInByte
        )

        if (audioRecorder == null) {
            return
        }

        if (audioRecorder!!.state != AudioRecord.STATE_INITIALIZED) {
            Log.e(logTag, "Audio Record can't initialize!")
            return
        }

        audioRecorder!!.startRecording()
        Log.i(logTag, "Start recording")

        while (shouldContinueRecording) {
            // Get audio data
            var length = audioRecorder!!.read(inputBuffer, 0, inputBuffer.size)

            // Prevent simultaneous access to buffer
            recordingBufferLock.lock();

            try {
                // Transfer data from audioBuffer to recordingBuffer
                recordingBuffer.put(inputBuffer)
            } catch (e: BufferOverflowException) {
                Log.w(logTag, "recording buffer overflow. some data is wasted.")
            } finally {
                recordingBufferLock.unlock()
            }

        }

        audioRecorder!!.stop()
        audioRecorder!!.release()
    }


    private fun startRecognition() {
        if (recognitionThread != null) {
            Log.i(logTag, "startRecognition() is called while it is already running")
            return
        }

        shouldContinueRecognition = true

        recognitionThread = thread() {
            recognize()
        }

        Log.d(logTag, "recognition thread is running")
    }


    private fun stopRecognition() {
        if (recognitionThread == null) {
            return
        }
        shouldContinueRecognition = false
        recognitionThread = null
        Log.d(logTag, "recognition thread is stopped")
    }


    private fun recognize() {
        val inputBuffer = ShortArray(recordingLength)
        val floatInputBuffer = Array(recordingLength) { FloatArray(1) }
        val outputScores = Array(1) { Array(32) { FloatArray(88) } }

        while (shouldContinueRecognition) {
            // Prevent simultaneous access to buffer
            recordingBufferLock.lock()

            try {
                val elemCount = recordingBuffer.position()

                for (i in elemCount until inputBuffer.size) {
                    inputBuffer[i - elemCount] = inputBuffer[i]
                }

                recordingBuffer.flip()
                recordingBuffer.get(inputBuffer, inputBuffer.size - elemCount, elemCount)
                recordingBuffer.clear()
            } catch (e: BufferUnderflowException) {
                Log.w(logTag, "recording buffer underflow.")
            } finally {
                recordingBufferLock.unlock()
            }

            inputBuffer.forEachIndexed { idx, elem ->
                floatInputBuffer[idx][0] = elem / Short.MAX_VALUE.toFloat()
            }

            val inputArray = arrayOf(floatInputBuffer)
            val outputMap: MutableMap<Int, Any> = HashMap()
            outputMap[0] = outputScores

            // Run the model
            tflInterpreter!!.runForMultipleInputsOutputs(inputArray, outputMap)

            val restemp = outputMap[0] as Array<Array<FloatArray>>
            val result = IntArray(88)

            for (i in 0 until 32) {
                for (j in 0 until 88) {
                    if (restemp[0][i][j] > 0) {
                        result[j] = result[j] + 1
                    }
                }
            }

            val playedChords = IntArray(result.count { it > 0 })
            var chordCount = 0

            // Send Event
            for (i in 0 until 88) {
                if (result[i] > 0) {
                    playedChords[chordCount] = i + 1
                    chordCount++
                }
            }

            activity?.runOnUiThread { eventSink?.success(playedChords) }

            try {
                Thread.sleep(minimumTimeBetweenSamplesInMS)
            } catch (e: InterruptedException) {
                Log.w(logTag, "Recognition thread run without sleeping")
            }
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events;
        start();
    }

    override fun onCancel(arguments: Any?) {
        stop();
        eventSink = null;
    }
}