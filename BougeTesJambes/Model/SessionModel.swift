//
//  SessionModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation
import SwiftUI

struct SessionModel: Identifiable, Hashable {
	var id = UUID()
	let sportType: Sport
	let timeObjectif: Int
	let ditanceObjectifInKm: Int
	let averageSpeedObjectif: Int

	let sessionTime: Int
	let sessionDistanceInKm: Double
	let sessionAverageSpeed: Double
}


enum Sport: String, CaseIterable {
	case walking, running

	public var sportName: String {
		switch self {
		case .walking:
			return "Marche"
		case .running:
			return "Course"
		}
	}

	public var sportIcon: Image {
		switch self {
		case .walking:
			return Image(systemName: "figure.walk")
		case .running:
			return Image(systemName: "figure.run")
		}
	}
}


extension SessionModel {
	static let sample = SessionModel(sportType: .running, timeObjectif: 120, ditanceObjectifInKm: 7, averageSpeedObjectif: 6, sessionTime: 35, sessionDistanceInKm: 5, sessionAverageSpeed: 4.5)
}
