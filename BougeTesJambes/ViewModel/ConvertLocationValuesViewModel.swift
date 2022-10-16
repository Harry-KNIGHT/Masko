//
//  ConvertLocationValuesViewModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation

class ConvertLocationValuesViewModel: ObservableObject {

	func convertMeterPerSecIntoKmHour(meterPerSec: Double) -> String {
		return "\(String(format: "%.2f", (meterPerSec * 3.6))) km/h"
	}
}
