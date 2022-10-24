//
//  ConvertDistanceViewModel.swift
//  Masko
//
//  Created by Elliot Knight on 24/10/2022.
//

import Foundation

class ConvertDistanceViewModel: ObservableObject {

	func isDistanceIsKm(_ distance: Double) -> String {
		(distance > 1_000 ? "\(String(format: "%02d", distance))km" : "\(String(format: "%.2f", distance))m")
	}
}
