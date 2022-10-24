//
//  TrainingsListView.swift
//  Masko
//
//  Created by Elliot Knight on 20/10/2022.
//

import SwiftUI
import WeatherKit

struct TrainingsListView: View {
	@StateObject var locationManager = LocationManager()
	@EnvironmentObject var weatherVM: WeatherViewModel
	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject var finishedSessionVM: FinishedSessionViewModel
	@StateObject var coreMotionManager = CoreMotionViewModel()

	@State private var path = NavigationPath()

	@State private var sessionTimer: Int = 0
	@State private var sessionDistanceInKm: Int = 0
	@State private var sessionAverageSpeed: Double = 0

	@State private var showSheet: Bool = false

	var body: some View {
		NavigationStack(path: $path) {
			ZStack {
				BackgroundLinearColor()
				ScrollView(.vertical, showsIndicators: false) {
					ForEach(sessionPropositions) { session in
						NavigationLink(
							value:
								SessionModel(
									image: session.sportType,
									sportType: session.sportType,
									difficulty: session.difficulty,
									ditanceObjectifInKm: session.ditanceObjectifInKm,
									sessionTime: sessionTimer,
									sessionDistanceInKm: Double(sessionDistanceInKm),
									sessionAverageSpeed: sessionAverageSpeed,
									distanceSpeedChart: nil,
									timeSpeedChart: nil,
									date: Date()
								)
						){
							SessionRecommandationRow(session: session)
								.shadow(color: Color("viewBackgroundColor") , radius: 5)
								.padding(10)
						}
					}
				}
			}
			.navigationDestination(for: SessionModel.self) { session in
				StartedSessionView(
					session:
						SessionModel(
							image: session.sportType,
							sportType: session.sportType,
							difficulty: session.difficulty,
							ditanceObjectifInKm: session.ditanceObjectifInKm,
							sessionTime: sessionTimer,
							sessionDistanceInKm: Double(sessionDistanceInKm),
							sessionAverageSpeed: sessionAverageSpeed,
							distanceSpeedChart: nil,
							timeSpeedChart: nil,
							date: nil),
					path: $path
				)
			}
			.onAppear {
				if locationManager.userLocation == nil {
					locationManager.requestLocation()
				}
				coreMotionManager.initializePodometer()
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
		}

		.task {
			if let location = locationManager.userLocation {
				await weatherVM.getWeather(lat: location.coordinate.latitude, long: location.coordinate.longitude)
			}
		}
	}
}

struct TrainingsListView_Previews: PreviewProvider {
	static var previews: some View {
		TrainingsListView()
			.environmentObject(WeatherViewModel())
			.environmentObject(FinishedSessionViewModel())

	}
}
