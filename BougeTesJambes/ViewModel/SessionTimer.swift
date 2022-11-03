//
//  SessionTimer.swift
//  Masko
//
//  Created by Elliot Knight on 24/10/2022.
//

import Foundation
import Combine
import ActivityKit

class SessionTimer: ObservableObject {
	let currentTimePublisher = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
	let cancellable: AnyCancellable?

	init() {
		self.cancellable = currentTimePublisher.connect() as? AnyCancellable
	}

	deinit {
		self.cancellable?.cancel()
	}
}

struct SessionAtributes: ActivityAttributes {
	public typealias SessionStatus = ContentState

	public struct ContentState: Codable, Hashable {
		var dateTimer: Date
	}
}
