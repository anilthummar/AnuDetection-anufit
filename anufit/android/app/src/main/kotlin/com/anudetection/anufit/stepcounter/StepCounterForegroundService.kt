package com.anudetection.anufit.stepcounter

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.anudetection.anufit.MainActivity
import com.anudetection.anufit.R

class StepCounterForegroundService : Service() {
    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        val notification = buildNotification()
        startForeground(NOTIFICATION_ID, notification)
        Log.i(TAG, "Foreground service started")
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onDestroy() {
        Log.i(TAG, "Foreground service destroyed")
        super.onDestroy()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val channel = NotificationChannel(
            CHANNEL_ID,
            "Step tracking",
            NotificationManager.IMPORTANCE_LOW,
        ).apply {
            description = "Keeps step counting active while you walk"
        }
        val manager = getSystemService(NotificationManager::class.java)
        manager.createNotificationChannel(channel)
    }

    private fun buildNotification(): Notification {
        val launchIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this,
            0,
            launchIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Anufit")
            .setContentText("Counting your steps")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentIntent(pendingIntent)
            .setOngoing(true)
            .setCategory(NotificationCompat.CATEGORY_SERVICE)
            .build()
    }

    companion object {
        private const val TAG = "StepCounterService"
        private const val CHANNEL_ID = "step_counter_tracking"
        private const val NOTIFICATION_ID = 42001

        fun start(context: Context) {
            val intent = Intent(context, StepCounterForegroundService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }

        fun stop(context: Context) {
            context.stopService(Intent(context, StepCounterForegroundService::class.java))
        }
    }
}
