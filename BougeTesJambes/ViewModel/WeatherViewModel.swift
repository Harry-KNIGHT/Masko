//
//  WeatherViewModel.swift
//  Masko
//
//  Created by Elliot Knight on 21/10/2022.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
	@Published var weather: Weather?

	@MainActor func getWeather(lat: Double, long: Double) async {
		do {
			weather = try await WeatherService.shared.weather(for: CLLocation(latitude: lat, longitude: long))
		} catch {
			print("Error fetching weather: \(error)")
		}
	}
}
