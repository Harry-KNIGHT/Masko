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
	let difficulty: Difficulty?
	let ditanceObjectifInMeters: Int

	let sessionTime: Int
	let sessionDistanceInMeters: Double
	let sessionAverageSpeed: Double
	let distanceSpeedChart: [DistanceSpeedChart]?
	let timeSpeedChart: [TimeSpeedChart]?
	let date: Date?
}

struct DistanceSpeedChart: Identifiable, Hashable {
	var id = UUID()
	let averageSpeed: Double
	let sessionDistance: Double
}

struct TimeSpeedChart: Identifiable, Hashable {
	var id = UUID()
	let time: Int
	let averageSpeed: Double
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
enum Difficulty: String, CaseIterable {
	case beginner, skilled, veteran

	public var difficultyName: String {
		switch self {
		case .beginner:
			return "Débutant"
		case .skilled:
			return "Expérimenté"
		case .veteran:
			return "Professionel"
		}
	}
}
