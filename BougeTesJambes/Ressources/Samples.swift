//
//  Samples.swift
//  Masko
//
//  Created by Elliot Knight on 20/10/2022.
//

import Foundation
extension DistanceSpeedChart {
	static let distanceSpeedArraySample = [
			DistanceSpeedChart(averageSpeed: 3, sessionDistance: 2),
			DistanceSpeedChart(averageSpeed: 4, sessionDistance: 4),
			DistanceSpeedChart(averageSpeed: 6, sessionDistance: 14),
			DistanceSpeedChart(averageSpeed: 9, sessionDistance: 25),
			DistanceSpeedChart(averageSpeed: 8, sessionDistance: 40)
	]
}

extension TimeSpeedChart {
	static let timeSpeedArraySample: [TimeSpeedChart] = [
		TimeSpeedChart(time: 0, averageSpeed: 0),
		TimeSpeedChart(time: 10, averageSpeed: 3.0),
		TimeSpeedChart(time: 40, averageSpeed: 3.4),
		TimeSpeedChart(time: 60, averageSpeed: 	3.5),
		TimeSpeedChart(time: 80, averageSpeed: 3.9),
		TimeSpeedChart(time: 120, averageSpeed: 4.0)
	]
}

extension SessionModel {
	static let sample = SessionModel(
		sessionTime: 35,
		sessionDistanceInMeters: 5,
		sessionAverageSpeed: 4.5,
		distanceSpeedChart: DistanceSpeedChart.distanceSpeedArraySample,
		timeSpeedChart: TimeSpeedChart.timeSpeedArraySample,
		date: Date()
	)
}
