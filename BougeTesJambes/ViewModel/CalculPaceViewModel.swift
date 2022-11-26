//
//  CalculPaceViewModel.swift
//  Masko
//
//  Created by Elliot Knight on 26/11/2022.
//

import Foundation

class CalculPaceViewModel: ObservableObject {

	func calculPace(startedSessionEpoch: Double, nowEpoch: Double, meters: Double) -> String {
		guard meters >= 1_000  else { return "00:00" }

		let distance: Double = (meters >= 1_000 ? meters / 1_000 : meters)
		let sessionTime = (nowEpoch - startedSessionEpoch)
		let paceInSec = Int(sessionTime / distance)

		let min = (paceInSec / 60)
		let sec = (paceInSec % 60)

		return (String(format: "%02i:%02i", min, sec))
	}
}
