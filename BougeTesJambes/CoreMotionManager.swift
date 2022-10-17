//
//  CoreMotionManager.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 17/10/2022.
//

import Foundation
import CoreMotion

class CoreMotionManager: ObservableObject {
	public let pedometer: CMPedometer = CMPedometer()
	@Published public var steps: Int?
	@Published public var distance: Double?

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
