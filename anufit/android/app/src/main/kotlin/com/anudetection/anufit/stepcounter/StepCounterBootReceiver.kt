package com.anudetection.anufit.stepcounter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class StepCounterBootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        if (intent?.action != Intent.ACTION_BOOT_COMPLETED) return
        Log.i(TAG, "Boot completed — checking step tracking restore")
        if (StepCounterPrefs.isTracking(context)) {
            StepCounterEngine.restoreAfterBoot(context)
        }
    }

    companion object {
        private const val TAG = "StepCounterBootRcvr"
    }
}
