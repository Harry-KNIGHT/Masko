//
//  FinishedSessionViewModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation

class FinishedSessionViewModel: ObservableObject {
	@Published public var fishishedSessions: [SessionModel] = []
	@Published public var speedSessionValues = [Double]()

	func addFinishedSession(sessionTime: Int, sessionDistanceInMeters: Double, sessionAverageSpeed: Double, distanceSpeedChart: [DistanceSpeedChart], timeSpeedChart: [TimeSpeedChart], date: Date) {

		let finishedSession = SessionModel(sessionTime: sessionTime, sessionDistanceInMeters: sessionDistanceInMeters, sessionAverageSpeed: averageSpeedFun, distanceSpeedChart: distanceSpeedChart, timeSpeedChart: timeSpeedChart, date: date)

		self.fishishedSessions.insert(finishedSession, at: 0)
		speedSessionValues.removeAll()
	}

	var averageSpeedFun: Double {
		let sum = speedSessionValues.reduce(0, +)
		return sum / Double(speedSessionValues.count)

	}
}
