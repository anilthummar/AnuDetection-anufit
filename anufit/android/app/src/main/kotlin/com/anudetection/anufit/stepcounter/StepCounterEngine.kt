package com.anudetection.anufit.stepcounter

import android.content.Context
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger

/**
 * Central engine bridging native sensors and Pigeon callbacks.
 * Maintains a single sensor listener shared by the foreground service and host API.
 */
object StepCounterEngine : StepCounterSensorManager.StepCounterSensorListener {
    private const val TAG = "StepCounterEngine"

    private lateinit var appContext: Context
    private var flutterApi: StepCounterFlutterApi? = null
    private var sensorManager: StepCounterSensorManager? = null

    private var isTracking = false
    private var isPaused = false

    fun initialize(context: Context, binaryMessenger: BinaryMessenger) {
        if (!::appContext.isInitialized) {
            appContext = context.applicationContext
            sensorManager = StepCounterSensorManager.getInstance(appContext, this)
        }
        flutterApi = StepCounterFlutterApi(binaryMessenger)
        Log.i(TAG, "Engine initialized")
    }

    fun isInitialized(): Boolean = ::appContext.isInitialized

    fun isSensorAvailable(): Boolean = sensorManager?.isSensorAvailable() ?: false

    fun getPlatformSource(): String = sensorManager?.getPlatformSource()
        ?: StepCounterSensorManager.SOURCE_UNKNOWN

    fun getHardwareTotal(): Int = sensorManager?.getHardwareTotal() ?: 0

    fun startTracking(): Boolean {
        ensureInitialized()
        if (!isSensorAvailable()) {
            emitError("sensor_unavailable", "Step sensor unavailable")
            return false
        }
        isTracking = true
        isPaused = false
        StepCounterPrefs.setTracking(appContext, true)
        StepCounterForegroundService.start(appContext)
        sensorManager?.start()
        return true
    }

    fun stopTracking(): Boolean {
        ensureInitialized()
        isTracking = false
        isPaused = false
        StepCounterPrefs.setTracking(appContext, false)
        sensorManager?.stop()
        StepCounterForegroundService.stop(appContext)
        return true
    }

    fun pauseTracking(): Boolean {
        ensureInitialized()
        if (!isTracking) return false
        isPaused = true
        sensorManager?.pause()
        return true
    }

    fun resumeTracking(): Boolean {
        ensureInitialized()
        if (!isTracking) return false
        isPaused = false
        sensorManager?.resume()
        return true
    }

    fun restoreAfterBoot(context: Context) {
        val ctx = context.applicationContext
        if (!StepCounterPrefs.isTracking(ctx)) return
        if (!::appContext.isInitialized) {
            appContext = ctx
            sensorManager = StepCounterSensorManager.getInstance(appContext, this)
        }
        Log.i(TAG, "Restoring tracking after boot")
        isTracking = true
        isPaused = false
        StepCounterForegroundService.start(appContext)
        sensorManager?.start()
    }

    override fun onHardwareTotal(total: Int, delta: Int, source: String) {
        val api = flutterApi ?: return
        val event = StepCounterNativeEvent(
            hardwareTotal = total.toLong(),
            delta = delta.toLong(),
            timestampMs = System.currentTimeMillis(),
            source = source,
        )
        api.onStepEvent(event) { result ->
            result.onFailure { error ->
                Log.e(TAG, "Failed to emit step event: ${error.message}")
            }
        }
    }

    override fun onSensorError(code: String, message: String) {
        emitError(code, message)
    }

    private fun emitError(code: String, message: String) {
        val api = flutterApi ?: return
        api.onStepError(StepCounterNativeError(code = code, message = message)) { result ->
            result.onFailure { error ->
                Log.e(TAG, "Failed to emit step error: ${error.message}")
            }
        }
    }

    private fun ensureInitialized() {
        check(isInitialized()) { "StepCounterEngine not initialized" }
    }
}
