package com.anudetection.anufit.stepcounter

class StepCounterHostApiImpl : StepCounterHostApi {
    override fun startTracking(): Boolean = StepCounterEngine.startTracking()

    override fun stopTracking(): Boolean = StepCounterEngine.stopTracking()

    override fun pauseTracking(): Boolean = StepCounterEngine.pauseTracking()

    override fun resumeTracking(): Boolean = StepCounterEngine.resumeTracking()

    override fun getHardwareTotal(): Long = StepCounterEngine.getHardwareTotal().toLong()

    override fun isSensorAvailable(): Boolean = StepCounterEngine.isSensorAvailable()

    override fun getPlatformSource(): String = StepCounterEngine.getPlatformSource()
}
