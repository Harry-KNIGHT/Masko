//
//  BougeTesJambesApp.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

@main
struct BougeTesJambesApp: App {
	@StateObject public var finishedSessionVM = FinishedSessionViewModel()
	@StateObject public var convertTimeVM = ConvertTimeViewModel()
	@StateObject public var playSongVM = PlaySongViewModel()
	@StateObject var weatherVM = WeatherViewModel()
	@StateObject var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
			TrainingsListView()
				.environmentObject(finishedSessionVM)
				.environmentObject(convertTimeVM)
				.environmentObject(playSongVM)
				.environmentObject(weatherVM)
				.environmentObject(locationManager)
        }
    }
}
