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
}
