//
//  ConvertDistanceViewModel.swift
//  Masko
//
//  Created by Elliot Knight on 24/10/2022.
//

import Foundation

class ConvertDistanceViewModel: ObservableObject {

	func turnThousandMToSimpleKM(_ distance: Double) -> Double {
		(distance > 1_000 ?  distance / 1_000 : distance )
	}
}
