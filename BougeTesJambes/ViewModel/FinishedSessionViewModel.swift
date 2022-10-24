//
//  FinishedSessionViewModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation

class FinishedSessionViewModel: ObservableObject {
	@Published public var fishishedSessions: [SessionModel] = []
	
	
	func addFinishedSession(image: Sport, sportType: Sport, difficulty: Difficulty, ditanceObjectifInMeters: Int, sessionTime: Int, sessionDistanceInMeters: Double, sessionAverageSpeed: Double, distanceSpeedChart: [DistanceSpeedChart], timeSpeedChart: [TimeSpeedChart], date: Date) {

		let finishedSession = SessionModel(image: image, sportType: sportType, difficulty: difficulty, ditanceObjectifInMeters: ditanceObjectifInMeters, sessionTime: sessionTime, sessionDistanceInMeters: sessionDistanceInMeters, sessionAverageSpeed: sessionAverageSpeed, distanceSpeedChart: distanceSpeedChart, timeSpeedChart: timeSpeedChart, date: date)

		self.fishishedSessions.append(finishedSession)
	}
}
