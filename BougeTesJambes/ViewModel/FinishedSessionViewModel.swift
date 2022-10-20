//
//  FinishedSessionViewModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation

class FinishedSessionViewModel: ObservableObject {
	@Published public var fishishedSessions: [SessionModel] = []
	
	
	func addFinishedSession(image: Sport, sportType: Sport, difficulty: Difficulty, timeObjectif: Int, ditanceObjectifInKm: Int, averageSpeedObjectif: Int, sessionTime: Int, sessionDistanceInKm: Double, sessionAverageSpeed: Double, distanceSpeedChart: [DistanceSpeedChart], date: Date) {

		let finishedSession = SessionModel(image: image, sportType: sportType, difficulty: difficulty, timeObjectif: timeObjectif, ditanceObjectifInKm: ditanceObjectifInKm, averageSpeedObjectif: averageSpeedObjectif, sessionTime: sessionTime, sessionDistanceInKm: sessionDistanceInKm, sessionAverageSpeed: sessionAverageSpeed, distanceSpeedChart: distanceSpeedChart, date: date)

		self.fishishedSessions.append(finishedSession)
	}
}
