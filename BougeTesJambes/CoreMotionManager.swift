//
//  CoreMotionManager.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 17/10/2022.
//

import Foundation
import CoreMotion

class CoreMotionManager: ObservableObject {
	@Published var steps: Int?
	@Published var distance: Double?
	private let pedometer: CMPedometer = CMPedometer()



	var isPedometerAvailable: Bool {
		return CMPedometer.isPedometerEventTrackingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isCadenceAvailable()
	}


	func updateUI(data: CMPedometerData) {
		steps = data.numberOfSteps.intValue
		guard let pedometerDistance = data.distance else { return }
		distance = pedometerDistance.doubleValue

	}
	
	func initializePodometer() {
		if isPedometerAvailable {
			pedometer.startUpdates(from: Date()) { [self] (data, error) in
				guard let data = data, error == nil else { return }
				updateUI(data: data)
			}
		}
	}
}
