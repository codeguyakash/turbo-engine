package com.example.android_tv_app

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.videoplayer/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "playVideo" -> {
                    val url = call.argument<String>("url")
                    if (!url.isNullOrEmpty()) {
                        try {
                            val intent = Intent(this, VideoPlayerActivity::class.java)
                            intent.putExtra("VIDEO_URL", url)
                            startActivity(intent)
                            result.success(null)
                        } catch (e: Exception) {
                            result.error("ACTIVITY_ERROR", "Failed to start VideoPlayerActivity", e.message)
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "Video URL is null or empty", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}