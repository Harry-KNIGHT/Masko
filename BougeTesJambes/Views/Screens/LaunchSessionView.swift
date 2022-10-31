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

	@State private var sessionTimer: Int = 0
	@State private var sessionDistanceInMeters: Int = 0
	@State private var sessionAverageSpeed: Double = 0

	@State private var showSheet: Bool = false
	@State private var startTrainingSession: Bool = false
	var body: some View {
		NavigationStack {
			ZStack {
				BackgroundLinearColor()
				VStack {
					Text("Appuie et fonce !")
						.fontWeight(.semibold)
						.font(.title)

						.foregroundColor(.accentColor)
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

						Image(systemName: "hare.fill")
							.font(.custom("",size: 100, relativeTo: .largeTitle))
							.foregroundColor(.white)
							.padding(50)
							.background(Color("buttonColor"))
							.clipShape(Circle())
							.shadow(color: .accentColor, radius: 10)
					}
				}
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
					.foregroundColor(.accentColor)
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
			if let weather = weatherVM.weather {
				weatherVM.weatherIcon = weather.currentWeather.symbolName
				weatherVM.weatherTemperature = weather.currentWeather.temperature.description
			}
		}
	}
}

struct LaunchSessionView_Previews: PreviewProvider {
	static var previews: some View {
		LaunchSessionView()
			.environmentObject(WeatherViewModel())
			.environmentObject(FinishedSessionViewModel())
			.environmentObject(LocationManager())

	}
}
