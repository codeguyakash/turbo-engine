package com.example.android_tv_app

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.media3.ui.PlayerView
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.common.MediaItem

class VideoPlayerActivity : AppCompatActivity() {

    private var player: ExoPlayer? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_video_player)

        val videoUrl = intent.getStringExtra("VIDEO_URL") ?: return
        val playerView: PlayerView = findViewById(R.id.player_view)


        player = ExoPlayer.Builder(this).build().apply {
            playerView.player = this
            val mediaItem = MediaItem.fromUri(videoUrl)
            setMediaItem(mediaItem)
            prepare()
            play()
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        player?.release()
        player = null
    }
}