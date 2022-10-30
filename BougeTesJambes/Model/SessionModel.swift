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
