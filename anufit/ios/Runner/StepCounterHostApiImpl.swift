import CoreMotion
import Foundation

final class StepCounterHostApiImpl: StepCounterHostApi {
  private let pedometer = CMPedometer()
  private var flutterApi: StepCounterFlutterApi?
  private var isTracking = false
  private var isPaused = false
  private var hardwareTotal = 0
  private var lastEmittedTotal = 0

  func attach(binaryMessenger: FlutterBinaryMessenger) {
    flutterApi = StepCounterFlutterApi(binaryMessenger: binaryMessenger)
  }

  func startTracking() throws -> Bool {
    guard CMPedometer.isStepCountingAvailable() else {
      emitError(code: "sensor_unavailable", message: "CMPedometer unavailable")
      return false
    }
    isTracking = true
    isPaused = false
    startPedometerUpdates()
    return true
  }

  func stopTracking() throws -> Bool {
    pedometer.stopUpdates()
    isTracking = false
    isPaused = false
    return true
  }

  func pauseTracking() throws -> Bool {
    guard isTracking else { return false }
    isPaused = true
    return true
  }

  func resumeTracking() throws -> Bool {
    guard isTracking else { return false }
    isPaused = false
    return true
  }

  func getHardwareTotal() throws -> Int64 {
    return Int64(hardwareTotal)
  }

  func isSensorAvailable() throws -> Bool {
    return CMPedometer.isStepCountingAvailable()
  }

  func getPlatformSource() throws -> String {
    return "cmpedometer"
  }

  private func startPedometerUpdates() {
    let startOfDay = Calendar.current.startOfDay(for: Date())
    pedometer.startUpdates(from: startOfDay) { [weak self] data, error in
      guard let self else { return }
      if let error {
        self.emitError(code: "pedometer_error", message: error.localizedDescription)
        return
      }
      guard self.isTracking, !self.isPaused else { return }
      let steps = data?.numberOfSteps.intValue ?? 0
      self.hardwareTotal = steps
      let delta = max(0, steps - self.lastEmittedTotal)
      self.lastEmittedTotal = steps
      self.emitStepEvent(total: steps, delta: delta)
    }
  }

  private func emitStepEvent(total: Int, delta: Int) {
    guard let flutterApi else { return }
    let event = StepCounterNativeEvent(
      hardwareTotal: Int64(total),
      delta: Int64(delta),
      timestampMs: Int64(Date().timeIntervalSince1970 * 1000),
      source: "cmpedometer"
    )
    flutterApi.onStepEvent(event: event) { _ in }
  }

  private func emitError(code: String, message: String) {
    guard let flutterApi else { return }
    let error = StepCounterNativeError(code: code, message: message)
    flutterApi.onStepError(error: error) { _ in }
  }
}
