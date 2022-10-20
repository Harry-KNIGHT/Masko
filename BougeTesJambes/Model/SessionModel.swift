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
	let image: Sport?
	let sportType: Sport
	let timeObjectif: Int
	let ditanceObjectifInKm: Int
	let averageSpeedObjectif: Int

	let sessionTime: Int
	let sessionDistanceInKm: Double
	let sessionAverageSpeed: Double
	let distanceSpeedChart: [DistanceSpeedChart]?
}

struct DistanceSpeedChart: Identifiable, Hashable {
	var id = UUID()
	let averageSpeed: Double
	let sessionDistance: Double
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

	public var sportImage: String {
		switch self {
		case .walking:
			return "walkingImage"
		case .running:
			return "runningImage"
		}
	}
}

var distanceSpeedArraySample = [
		DistanceSpeedChart(averageSpeed: 3, sessionDistance: 2),
		DistanceSpeedChart(averageSpeed: 4, sessionDistance: 4),
		DistanceSpeedChart(averageSpeed: 6, sessionDistance: 14),
		DistanceSpeedChart(averageSpeed: 9, sessionDistance: 25),
		DistanceSpeedChart(averageSpeed: 8, sessionDistance: 40)
]

extension SessionModel {
	static let sample = SessionModel(
		image: .running,
		sportType: .running,
		timeObjectif: 120,
		ditanceObjectifInKm: 7,
		averageSpeedObjectif: 6,
		sessionTime: 35, sessionDistanceInKm: 5,
		sessionAverageSpeed: 4.5,
		distanceSpeedChart: distanceSpeedArraySample
	)
}
