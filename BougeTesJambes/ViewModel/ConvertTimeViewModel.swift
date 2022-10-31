//
//  ConvertTimeViewModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation

class ConvertTimeViewModel: ObservableObject {

	func convertSecInMin(second: Int) -> Int {
		return (second * 60)
	}

	func convertSecInTime(timeInSeconds: Int) -> String {
		let hour = timeInSeconds / 3600
		let minutes = timeInSeconds / 60
		let seconds = timeInSeconds % 60

		return String(format: "%02d:%02d:%02d", hour, minutes, seconds)
	}

	func isSessionTimeDone(convertedSecInMin: Int, sessionTime: Int) -> Bool {
		let convertedSecInMin = convertSecInMin(second: convertedSecInMin)

		return sessionTime > convertedSecInMin
	}

	func isSessionTimeBiggerThanConvertedTime(sessionTime: Int, convertedSecInMin: Int) -> Bool {
		let convertedSecInMin = convertSecInMin(second: convertedSecInMin)
		return sessionTime == convertedSecInMin
	}

	func convertDateFormat(date: Date) -> String {
		let formatter = DateFormatter()

		formatter.dateFormat = "dd/MM/YY"

		return formatter.string(from: date)
	}
}
