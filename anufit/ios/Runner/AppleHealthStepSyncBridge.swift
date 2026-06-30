import Foundation
import HealthKit

/// Scaffold for future Apple Health historical step synchronization.
/// Phase 4 wires CMPedometer for live tracking; HealthKit import/export comes later.
final class AppleHealthStepSyncBridge {
  static let shared = AppleHealthStepSyncBridge()

  private let healthStore = HKHealthStore()

  var isHealthDataAvailable: Bool {
    HKHealthStore.isHealthDataAvailable()
  }

  func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
    guard isHealthDataAvailable else {
      completion(false, nil)
      return
    }

    guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
      completion(false, nil)
      return
    }

    healthStore.requestAuthorization(toShare: [], read: [stepType]) { success, error in
      completion(success, error)
    }
  }

  func fetchHistoricalSteps(
    from startDate: Date,
    to endDate: Date,
    completion: @escaping (Result<Int, Error>) -> Void
  ) {
    guard isHealthDataAvailable,
          let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
      completion(.success(0))
      return
    }

    let predicate = HKQuery.predicateForSamples(
      withStart: startDate,
      end: endDate,
      options: .strictStartDate
    )

    let query = HKStatisticsQuery(
      quantityType: stepType,
      quantitySamplePredicate: predicate,
      options: .cumulativeSum
    ) { _, statistics, error in
      if let error {
        completion(.failure(error))
        return
      }
      let steps = statistics?.sumQuantity()?.doubleValue(for: .count()) ?? 0
      completion(.success(Int(steps)))
    }

    healthStore.execute(query)
  }
}
