//
//  TrainingsListView.swift
//  Masko
//
//  Created by Elliot Knight on 20/10/2022.
//

import SwiftUI
import WeatherKit

struct LaunchSessionView: View {
	@EnvironmentObject var locationManager: LocationManager
	@EnvironmentObject var weatherVM: WeatherViewModel
	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject var finishedSessionVM: FinishedSessionViewModel

	@State private var path = NavigationPath()

	@State private var sessionTimer: Int = 0
	@State private var sessionDistanceInMeters: Int = 0
	@State private var sessionAverageSpeed: Double = 0

	@State private var showSheet: Bool = false

	var body: some View {
		NavigationStack(path: $path) {
			ZStack {
				BackgroundLinearColor()
				VStack {
					NavigationLink(
						value:
							SessionModel(
								sessionTime: sessionTimer,
								sessionDistanceInMeters: Double(sessionDistanceInMeters),
								sessionAverageSpeed: sessionAverageSpeed,
								distanceSpeedChart: nil,
								timeSpeedChart: nil,
								date: Date()
							)
					){

						Text("Hello world")
					}
				}
			}
			.navigationDestination(for: SessionModel.self) { session in
				StartedSessionView(
					session:
						SessionModel(
							sessionTime: sessionTimer,
							sessionDistanceInMeters: Double(sessionDistanceInMeters),
							sessionAverageSpeed: sessionAverageSpeed,
							distanceSpeedChart: nil,
							timeSpeedChart: nil,
							date: nil),
					path: $path
				)
			}
			.navigationTitle("MASKO")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					HStack {
						if let weather = weatherVM.weather {
							Image(systemName: weather.currentWeather.symbolName)
							Text(weather.currentWeather.temperature.description)
						}
					}
					.foregroundColor(.primary)
					.font(.headline)
				}

				ToolbarItem(placement: .navigationBarTrailing) {
					if !finishedSessionVM.fishishedSessions.isEmpty {
						ShowFinishedSessionSheetButtonCell(showSheet: $showSheet)
					}
				}
			}
			.toolbarColorScheme((colorScheme == .dark ? .dark : .light), for: .navigationBar)

			.toolbarBackground(Color("toolbarColor"), for: .navigationBar)
			.toolbarBackground(.visible, for: .navigationBar)
			.navigationBarTitleDisplayMode(.inline)
		}

		.task  {
			if let location = locationManager.userLocation {

				await weatherVM.getWeather(
					lat: location.coordinate.latitude,
					long: location.coordinate.longitude
				)
				
			}
		}
	}
}

struct LaunchSessionView_Previews: PreviewProvider {
	static var previews: some View {
		LaunchSessionView()
			.environmentObject(WeatherViewModel())
			.environmentObject(FinishedSessionViewModel())

	}
}
