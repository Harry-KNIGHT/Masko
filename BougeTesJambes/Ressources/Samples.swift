//
//  Samples.swift
//  Masko
//
//  Created by Elliot Knight on 20/10/2022.
//

import Foundation

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
		difficulty: .beginner,
		ditanceObjectifInKm: 7,
		sessionTime: 35, sessionDistanceInKm: 5,
		sessionAverageSpeed: 4.5,
		distanceSpeedChart: distanceSpeedArraySample,
		date: Date()
	)
}
