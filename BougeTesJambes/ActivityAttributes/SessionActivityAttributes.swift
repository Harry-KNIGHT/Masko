//
//  SessionActivityAttributes.swift
//  Masko
//
//  Created by Elliot Knight on 03/11/2022.
//

import SwiftUI
import ActivityKit

struct SessionActivityAttributes: ActivityAttributes {
	public typealias SessionStatus = ContentState

	public struct ContentState: Codable, Hashable {
		var dateTimer: Date
		var sessionDistanceDone: Double
		var sessionSpeed: Double
	}
}
