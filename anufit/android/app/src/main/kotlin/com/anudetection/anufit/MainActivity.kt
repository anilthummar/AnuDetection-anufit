package com.anudetection.anufit

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import com.anudetection.anufit.stepcounter.StepCounterEngine
import com.anudetection.anufit.stepcounter.StepCounterHostApi
import com.anudetection.anufit.stepcounter.StepCounterHostApiImpl

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        StepCounterEngine.initialize(applicationContext, flutterEngine.dartExecutor.binaryMessenger)
        StepCounterHostApi.setUp(flutterEngine.dartExecutor.binaryMessenger, StepCounterHostApiImpl())
    }
}
