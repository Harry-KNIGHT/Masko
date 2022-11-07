//
//  TrainingsListView.swift
//  Masko
//
//  Created by Elliot Knight on 20/10/2022.
//

import SwiftUI
import WeatherKit
import ActivityKit

struct LaunchSessionView: View {
	@EnvironmentObject var locationManager: LocationManager
	@EnvironmentObject var weatherVM: WeatherViewModel
	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject var finishedSessionVM: FinishedSessionViewModel
	@EnvironmentObject var motionManager: CoreMotionViewModel

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

	@Namespace private var nameSpace
	@State private var activity: Activity<SessionActivityAttributes>?
	@State private var dateTimer: Date?
	@State private var endSessionAnimationButton: Bool = false
	@State private var startSessionAnimationButton: Bool = false
	var body: some View {
		NavigationStack {
			ZStack {
				BackgroundLinearColor()
				if willStartTrainingSession {
					StartSessionButton(willStartTrainingSession: $willStartTrainingSession, nameSpace: nameSpace, endSessionAnimationButton: $endSessionAnimationButton)

					 .transition(AnyTransition.opacity.animation(.easeOut(duration: 1)))

				} else {

						StartedSessionView(
							session:
								SessionModel(
									sessionTime: sessionTimer,
									sessionDistanceInMeters: sessionDistanceInMeters,
									sessionAverageSpeed: sessionAverageSpeed,
									distanceSpeedChart: nil,
									timeSpeedChart: nil,
									date: nil
								),
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
							nameSpace: nameSpace,
							dateTimer: $dateTimer,
							endSessionAnimationButton: $endSessionAnimationButton,
							startSessionAnimationButton: $startSessionAnimationButton
						)
						.transition(AnyTransition.opacity.animation(.easeIn(duration: 1)))
						.onChange(of: locationManager.userLocation) { location  in
							if let location {
								// Update live activity in background
								let updateActivity = SessionActivityAttributes.SessionStatus(dateTimer: .now, sessionDistanceDone: sessionDistanceInMeters, sessionSpeed: location.speed)
								Task {
									await activity?.update(using: updateActivity)
								}
							}
						}
						.onChange(of: motionManager.distance) { distance in
							if let distance {
								let updateActivity = SessionActivityAttributes.SessionStatus(dateTimer: .now, sessionDistanceDone: sessionDistanceInMeters, sessionSpeed: sessionAverageSpeed)
								Task {
									await activity?.update(using: updateActivity)
								}
							}
						}
				}
			}
			.onTapGesture {
				withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
					willStartTrainingSession = false
					startSessionAnimationButton = true

					// Start Live Activities
					dateTimer = .now

					guard dateTimer != nil else { return }

					//	End distance and verifications

					let attribute = SessionActivityAttributes()
					let state = SessionActivityAttributes.ContentState(dateTimer: .now, sessionDistanceDone: sessionDistanceInMeters, sessionSpeed: sessionAverageSpeed)

					activity = try? Activity<SessionActivityAttributes>.request(attributes: attribute, contentState: state, pushType: nil)
				}
			}
			.onChange(of: willStartTrainingSession) { _ in
				if willStartTrainingSession {
					// Stop Live activities
					guard let dateTimer else { return }
					let state = SessionActivityAttributes.ContentState(dateTimer: dateTimer, sessionDistanceDone: sessionDistanceInMeters, sessionSpeed: sessionAverageSpeed)

					Task {
						await activity?.end(using: state, dismissalPolicy: .immediate)
					}
					self.dateTimer = nil
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
