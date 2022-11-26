//
//  CalculPaceViewModel.swift
//  Masko
//
//  Created by Elliot Knight on 26/11/2022.
//

import Foundation

class CalculPaceViewModel: ObservableObject {

	func calculPace(startedSessionEpoch: Double, nowEpoch: Double, meters: Double) -> String {

		let distance: Double = (meters > 999 ? meters / 1_000 : meters)
		let sessionTime = (nowEpoch - startedSessionEpoch)
		let paceInSec = (sessionTime / distance)

		let min = (Int(paceInSec) / 60)
		let sec = (Int(paceInSec) % 60)

		if meters > 1_000 {
			return (String(format: "%02i:%02i min/km", min, sec))
		} else {
			return "00:00"
		}
	}
}
