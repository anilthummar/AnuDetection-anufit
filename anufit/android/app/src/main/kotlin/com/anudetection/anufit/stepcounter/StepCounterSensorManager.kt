package com.anudetection.anufit.stepcounter

import android.content.Context
import android.content.SharedPreferences
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import kotlin.math.sqrt

/**
 * Single shared sensor listener for step counting.
 * TYPE_STEP_COUNTER is primary; TYPE_STEP_DETECTOR for live deltas;
 * accelerometer is used only when hardware step sensors are unavailable.
 */
class StepCounterSensorManager private constructor(
    context: Context,
    private val listener: StepCounterSensorListener,
) : SensorEventListener {
    interface StepCounterSensorListener {
        fun onHardwareTotal(total: Int, delta: Int, source: String)
        fun onSensorError(code: String, message: String)
    }

    private val appContext = context.applicationContext
    private val sensorManager =
        appContext.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    private val stepCounterSensor: Sensor? =
        sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)
    private val stepDetectorSensor: Sensor? =
        sensorManager.getDefaultSensor(Sensor.TYPE_STEP_DETECTOR)
    private val accelerometerSensor: Sensor? =
        sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

    private var hardwareTotal = 0
    private var pendingDetectorSteps = 0
    private var accelerometerTotal = 0
    private var activeSource = SOURCE_UNKNOWN
    private var listening = false
    private var paused = false

    private var lastAccelMagnitude = 0f
    private var lastStepTimestamp = 0L
    private var lastAccel = FloatArray(3)

    fun isSensorAvailable(): Boolean {
        return stepCounterSensor != null || stepDetectorSensor != null || accelerometerSensor != null
    }

    fun getPlatformSource(): String = activeSource

    fun getHardwareTotal(): Int = effectiveTotal()

    fun start() {
        if (listening) return
        listening = true
        paused = false
        registerSensors()
        Log.i(TAG, "Sensor listening started (source=$activeSource)")
    }

    fun stop() {
        if (!listening) return
        unregisterSensors()
        listening = false
        paused = false
        pendingDetectorSteps = 0
        Log.i(TAG, "Sensor listening stopped")
    }

    fun pause() {
        paused = true
    }

    fun resume() {
        paused = false
    }

    private fun registerSensors() {
        when {
            stepCounterSensor != null -> {
                activeSource = SOURCE_STEP_COUNTER
                sensorManager.registerListener(this, stepCounterSensor, SensorManager.SENSOR_DELAY_NORMAL)
                if (stepDetectorSensor != null) {
                    sensorManager.registerListener(this, stepDetectorSensor, SensorManager.SENSOR_DELAY_FASTEST)
                }
            }
            stepDetectorSensor != null -> {
                activeSource = SOURCE_STEP_DETECTOR
                sensorManager.registerListener(this, stepDetectorSensor, SensorManager.SENSOR_DELAY_FASTEST)
            }
            accelerometerSensor != null -> {
                activeSource = SOURCE_ACCELEROMETER
                sensorManager.registerListener(this, accelerometerSensor, SensorManager.SENSOR_DELAY_GAME)
            }
            else -> {
                activeSource = SOURCE_UNKNOWN
                listener.onSensorError("sensor_unavailable", "No step sensors available")
            }
        }
    }

    private fun unregisterSensors() {
        sensorManager.unregisterListener(this)
    }

    private fun effectiveTotal(): Int {
        return when (activeSource) {
            SOURCE_ACCELEROMETER -> accelerometerTotal
            else -> hardwareTotal + pendingDetectorSteps
        }
    }

    override fun onSensorChanged(event: SensorEvent) {
        if (paused || !listening) return

        when (event.sensor.type) {
            Sensor.TYPE_STEP_COUNTER -> onStepCounter(event)
            Sensor.TYPE_STEP_DETECTOR -> onStepDetector()
            Sensor.TYPE_ACCELEROMETER -> onAccelerometer(event)
        }
    }

    private fun onStepCounter(event: SensorEvent) {
        val newTotal = event.values[0].toInt()
        val previous = effectiveTotal()
        hardwareTotal = newTotal
        pendingDetectorSteps = 0
        val delta = (newTotal - previous).coerceAtLeast(0)
        listener.onHardwareTotal(newTotal, delta, SOURCE_STEP_COUNTER)
    }

    private fun onStepDetector() {
        if (activeSource == SOURCE_ACCELEROMETER) return
        pendingDetectorSteps += 1
        listener.onHardwareTotal(effectiveTotal(), 1, SOURCE_STEP_DETECTOR)
    }

    private fun onAccelerometer(event: SensorEvent) {
        if (activeSource != SOURCE_ACCELEROMETER) return

        val x = event.values[0]
        val y = event.values[1]
        val z = event.values[2]
        val magnitude = sqrt(x * x + y * y + z * z)

        val deltaVector = sqrt(
            (x - lastAccel[0]) * (x - lastAccel[0]) +
                (y - lastAccel[1]) * (y - lastAccel[1]) +
                (z - lastAccel[2]) * (z - lastAccel[2]),
        )
        lastAccel = floatArrayOf(x, y, z)

        val now = System.currentTimeMillis()
        if (deltaVector > ACCEL_STEP_THRESHOLD &&
            magnitude > GRAVITY * 0.9f &&
            now - lastStepTimestamp > MIN_STEP_INTERVAL_MS
        ) {
            lastStepTimestamp = now
            accelerometerTotal += 1
            listener.onHardwareTotal(accelerometerTotal, 1, SOURCE_ACCELEROMETER)
        }
        lastAccelMagnitude = magnitude
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) = Unit

    companion object {
        private const val TAG = "StepCounterSensorMgr"
        const val SOURCE_STEP_COUNTER = "step_counter"
        const val SOURCE_STEP_DETECTOR = "step_detector"
        const val SOURCE_ACCELEROMETER = "accelerometer"
        const val SOURCE_UNKNOWN = "unknown"

        private const val ACCEL_STEP_THRESHOLD = 1.2f
        private const val GRAVITY = 9.81f
        private const val MIN_STEP_INTERVAL_MS = 300L

        @Volatile
        private var instance: StepCounterSensorManager? = null

        fun getInstance(
            context: Context,
            listener: StepCounterSensorListener,
        ): StepCounterSensorManager {
            return instance ?: synchronized(this) {
                instance ?: StepCounterSensorManager(context, listener).also { instance = it }
            }
        }
    }
}

object StepCounterPrefs {
    private const val PREFS_NAME = "step_counter_engine"
    private const val KEY_TRACKING = "is_tracking"

    fun isTracking(context: Context): Boolean {
        return prefs(context).getBoolean(KEY_TRACKING, false)
    }

    fun setTracking(context: Context, tracking: Boolean) {
        prefs(context).edit().putBoolean(KEY_TRACKING, tracking).apply()
    }

    private fun prefs(context: Context): SharedPreferences {
        return context.applicationContext.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    }
}
