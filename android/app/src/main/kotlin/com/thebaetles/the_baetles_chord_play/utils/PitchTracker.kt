package com.thebaetles.the_baetles_chord_play

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.ActivityCompat.requestPermissions
import java.nio.BufferOverflowException
import java.nio.ShortBuffer
import java.util.concurrent.locks.ReentrantLock
import kotlin.concurrent.thread


class PitchTracker {
    // Audio Recording Setting
    private val audioSource : Int = MediaRecorder.AudioSource.MIC
    private val sampleRate : Int = 16000
    private val recordingLength : Int = 17920
    private val channel : Int = AudioFormat.CHANNEL_IN_MONO
    private val encodingType : Int = AudioFormat.ENCODING_PCM_16BIT

    private val logTag : String = "PitchTracker"

    private var recorderThread : Thread? = null
    private var audioRecorder : AudioRecord? = null
    private var recordingBuffer = ShortBuffer.allocate(recordingLength)
    private var recordingBufferLock : ReentrantLock = ReentrantLock()

    private var continueRecord = false;


    fun start() {
        startRecording()
    }


    fun startRecording() {
        Log.i("test1", "dddddd")

        if (recorderThread != null) {
            Log.i(logTag, "startRecognition() is called while it is already running")
        }

        // Start recording data
        recorderThread = thread() {
            record()
        }

        continueRecord = true

        Log.d("thread", "thread is running!")
    }


    private fun stopRecroding() {
        continueRecord = false;
    }


    @SuppressLint("MissingPermission")
    private fun record() {
        // Calculate the minimum recording buffer size and create buffer
        var bufferSizeInByte = AudioRecord.getMinBufferSize(sampleRate, channel, encodingType)

        if (bufferSizeInByte == AudioRecord.ERROR || bufferSizeInByte == AudioRecord.ERROR_BAD_VALUE) {
            bufferSizeInByte = sampleRate * 2
        }

        var audioBuffer : ShortArray = ShortArray(size = bufferSizeInByte / 2);

        // Create AudioRecord object
        audioRecorder = AudioRecord(audioSource, sampleRate, channel, encodingType, bufferSizeInByte)

        if (audioRecorder == null) {
            return
        }

        audioRecorder!!.startRecording()
        Log.i(logTag, "Start recording")

        while (continueRecord) {
            // Get audio data
            var length = audioRecorder!!.read(audioBuffer, 0, audioBuffer.size)

            // Prevent simultaneous access to buffers.
            recordingBufferLock.lock();

            try {
                // transfer data from audioBuffer to recordingBuffer
                recordingBuffer.put(audioBuffer);
            } catch (e : BufferOverflowException) {
                Log.e(logTag, "recording buffer overflow. some data is wasted. ${e.message}")
            }

            recordingBufferLock.unlock()
        }

        audioRecorder!!.stop()
        audioRecorder!!.release()
    }
}