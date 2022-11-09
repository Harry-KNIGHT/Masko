//
//  FinishedSessionViewModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation

class FinishedSessionViewModel: ObservableObject {
	@Published public var fishishedSessions: [SessionModel]
	@Published public var speedSessionValues = [Double]()

	init() {
		if let data = UserDefaults.standard.data(forKey: "SavedData") {
			if let decoded = try? JSONDecoder().decode([SessionModel].self, from: data) {
				fishishedSessions = decoded
				return
			}
		}
		fishishedSessions = []
	}

	func save() {
		if let encoded = try? JSONEncoder().encode(fishishedSessions) {
			UserDefaults.standard.set(encoded, forKey: "SavedData")

		}
	}

	func addFinishedSession(sessionTime: Int, sessionDistanceInMeters: Double, sessionAverageSpeed: Double, distanceSpeedChart: [DistanceSpeedChart], timeSpeedChart: [TimeSpeedChart], date: Date) {

		let finishedSession = SessionModel(sessionTime: sessionTime, sessionDistanceInMeters: sessionDistanceInMeters, sessionAverageSpeed: averageSpeed, distanceSpeedChart: distanceSpeedChart, timeSpeedChart: timeSpeedChart, date: date)

		self.fishishedSessions.insert(finishedSession, at: 0)
		speedSessionValues.removeAll()
		save()
	}

	var averageSpeed: Double {
		let sum = speedSessionValues.reduce(0, +)
		return sum / Double(speedSessionValues.count)

	}
}
