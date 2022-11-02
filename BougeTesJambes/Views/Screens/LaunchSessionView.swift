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
	@State private var sessionDistanceInMeters: Double = 0
	@State private var sessionAverageSpeed: Double = 0

	@State private var showSheet: Bool = false
	@State private var willStartTrainingSession: Bool = true
	@State private var isSessionPaused: Bool = false
	@State private var distanceSpeedChartValues = [DistanceSpeedChart]()
	@State private var timeSpeedChart = [TimeSpeedChart]()
	@State private var appInBackgroundSceneEpoch = 0
	@State private var appGoBackInActiveSceneEpoch = 0
	@State private var calculBackgroundTimePassed = 0

	@State private var animationAmount = 1.0

	@Namespace private var nameSpace
	var body: some View {
		NavigationStack {
			ZStack {
				BackgroundLinearColor()
				if willStartTrainingSession {
					StartSessionButton(willStartTrainingSession: $willStartTrainingSession, animationAmount: $animationAmount, nameSpace: nameSpace)

					 .transition(AnyTransition.opacity.animation(.easeOut(duration: 1)))

				} else {
					StartedSessionView(
						session: SessionModel(sessionTime: sessionTimer, sessionDistanceInMeters: sessionDistanceInMeters, sessionAverageSpeed: sessionAverageSpeed, distanceSpeedChart: nil, timeSpeedChart: nil, date: nil),
						sessionTimer: $sessionTimer,
						sessionDistanceInMeters: $sessionDistanceInMeters,
						sessionAverageSpeed: $sessionAverageSpeed,
						isSessionPaused: $isSessionPaused,
						distanceSpeedChartValues: $distanceSpeedChartValues,
						timeSpeedChart: $timeSpeedChart,
						appInBackgroundSceneEpoch: $appInBackgroundSceneEpoch,
						appGoBackInActiveSceneEpoch: $appGoBackInActiveSceneEpoch,
						calculBackgroundTimePassed: $calculBackgroundTimePassed,
						willStartTrainingSession: $willStartTrainingSession,
						nameSpace: nameSpace
					)

					.transition(AnyTransition.opacity.animation(.easeIn(duration: 1)))
				}
			}
			.onTapGesture {
				withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
					willStartTrainingSession = false
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
					if !finishedSessionVM.fishishedSessions.isEmpty, willStartTrainingSession {
						ShowFinishedSessionSheetButtonCell(showSheet: $showSheet)
					}
				}
			}
			.toolbarColorScheme((colorScheme == .dark ? .dark : .light), for: .navigationBar)

			.toolbarBackground(Color("toolbarColor"), for: .navigationBar)
			.toolbarBackground(.visible, for: .navigationBar)
			.navigationBarTitleDisplayMode(.inline)
		}

		.task {
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
			.environmentObject(LocationManager())

	}
}
