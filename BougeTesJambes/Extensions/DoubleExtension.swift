//
//  DoubleExtension.swift
//  Masko
//
//  Created by Elliot Knight on 25/10/2022.
//

import Foundation

extension Double {
	var turnMPerSecToKmPerH: Double {
		self * 3.6
	}

	var turnThousandMToKm: Double {
		(self > 1_000 ?  (self / 1_000) : self )
	}

	var twoDecimalDigits: String {
		String(format: "%.2f", self)
	}
	var isKmOrMtwoDigits: String {
		String(format: "%.2f \(self > 1_000 ? "km" : "m")", (self > 1_000 ? self.turnThousandMToKm : self))
	}

	var turnMperSecToKmPerMin: String {
		String(format: "%.2f", self * 0.06)
	}

}
