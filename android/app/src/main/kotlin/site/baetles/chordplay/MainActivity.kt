package site.baetles.chordplay

import android.Manifest
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.core.app.ActivityCompat
import site.baetles.chordplay.PitchTracker
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    private val PERMISSION_REQUEST_CODE = 1001;

    private val METHOD_CHANNEL = "site.baetles.chordplay/chord-detection"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.RECORD_AUDIO
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            var permissions = arrayOf(
                Manifest.permission.RECORD_AUDIO,
                Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
            )
            ActivityCompat.requestPermissions(this, permissions, 100)
        }
    }

    // flutter method channel 연결
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "startDetectingChord") {
                // permission check
                if (ActivityCompat.checkSelfPermission(
                        this,
                        Manifest.permission.RECORD_AUDIO
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    result.error("403", "RECORD_AUDIO permission not granted", null);
                }

                // 음 판별 시작
                val pitchTracker : PitchTracker = PitchTracker(this)
                pitchTracker.start()

                result.success(1234)
            } else {
                result.notImplemented()
            }
        }
    }

}
