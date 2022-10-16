//
//  FinishedSessionViewModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation

class FinishedSessionViewModel: ObservableObject {
	@Published public var fishishedSessions: [SessionModel] = []

	func addFinishedSession(sportType: Sport, timeObjectif: Int, ditanceObjectifInKm: Int, averageSpeedObjectif: Int, sessionTime: Int, sessionDistanceInKm: Int, sessionAverageSpeed: Double) {

		let finishedSession = SessionModel(sportType: sportType, timeObjectif: timeObjectif, ditanceObjectifInKm: ditanceObjectifInKm, averageSpeedObjectif: averageSpeedObjectif, sessionTime: sessionTime, sessionDistanceInKm: sessionDistanceInKm, sessionAverageSpeed: sessionAverageSpeed)

		self.fishishedSessions.append(finishedSession)
	}
}
