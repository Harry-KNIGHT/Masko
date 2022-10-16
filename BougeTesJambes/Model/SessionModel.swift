//
//  SessionModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation

struct SessionModel: Identifiable, Hashable {
	var id = UUID()
	let sportType: Sport
	let timeObjectif: Int
	let ditanceObjectifInKm: Int
	let averageSpeedObjectif: Double

	let sessionTime: Int
	let sessionDistanceInKm: Int
	let sessionAverageSpeed: Double
}


enum Sport: String, CaseIterable {
	case walking, running

	public var sportName: String {
		switch self {
		case .walking:
			return "Course"
		case .running:
			return "Marche"
		}
	}
}


extension SessionModel {
	static let sample = SessionModel(sportType: .running, timeObjectif: 120, ditanceObjectifInKm: 7, averageSpeedObjectif: 6, sessionTime: 35, sessionDistanceInKm: 5, sessionAverageSpeed: 4.5)
}
