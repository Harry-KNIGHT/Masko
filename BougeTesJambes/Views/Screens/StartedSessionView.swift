//
//  StartedSessionView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI
import ActivityKit

struct StartedSessionView: View {
	let session: SessionModel
	@EnvironmentObject var locationManager: LocationManager
	@EnvironmentObject var motionManager: CoreMotionViewModel

	@EnvironmentObject public var finishedSesionVM: FinishedSessionViewModel
	@EnvironmentObject public var convertTimeVM: ConvertTimeViewModel

	@ObservedObject public var playSongVM = PlaySongViewModel()

	@Binding var sessionTimer: Int
	@Binding var sessionDistanceInMeters: Double
	@Binding var sessionAverageSpeed: Double

	@Binding var isSessionPaused: Bool
	@Binding var distanceSpeedChartValues: [DistanceSpeedChart]

	@StateObject var timerPublisher = SessionTimer()

	@Binding var timeSpeedChart: [TimeSpeedChart]

	@Environment(\.colorScheme) var colorScheme
	@Environment(\.scenePhase) var scenePhase

	@Binding var appInBackgroundSceneEpoch: Int
	@Binding var appGoBackInActiveSceneEpoch: Int
	@Binding var calculBackgroundTimePassed: Int

	@Binding var willStartTrainingSession: Bool

	var nameSpace: Namespace.ID

	@State private var activity: Activity<SessionActivityAttributes>?
	@Binding var dateTimer: Date?
	@Binding var endSessionAnimationButton: Bool
	@Binding var startSessionAnimationButton: Bool
	var body: some View {
		ZStack {
			BackgroundLinearColor()
			VStack {
				Spacer()

				SessionInformation(
					sfSymbol: "stopwatch",
					sessionValue: "\(String(convertTimeVM.convertSecInTime(timeInSeconds: sessionTimer)))"
				)

				Spacer()
				HStack {

					SessionInformation(
						sfSymbol: "flag",
						objectif: "\(sessionDistanceInMeters > 1_000 ? "km" : "m")",
						sessionValue: "\(String(format: "%.2f", sessionDistanceInMeters.turnThousandMToKm))"
					)

					Spacer()
					if let location = locationManager.userLocation {
						SessionInformation(
							sfSymbol: "speedometer",
							objectif: "km/h",
							sessionValue: "\( location.speed < 0 ? "0.00" : String(format: "%.2f", location.speed.turnMPerSecToKmPerH))"
						)

					}
				}
				.padding(.horizontal)
				Spacer()

				SessionRunningButton(isSessionPaused: $isSessionPaused, startSessionAnimationButton: $startSessionAnimationButton)
					.matchedGeometryEffect(id: "button", in: nameSpace, properties: .position)

					.padding(.bottom, 30)
					.alert("Arrêter la session ?", isPresented: $isSessionPaused) {
						Button("Oui", role: .destructive) {

							locationManager.showAndUseBackgroundActivity = false
							withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
								willStartTrainingSession = true
							}

							self.finishedSesionVM.addFinishedSession(sessionTime: sessionTimer, sessionDistanceInMeters: sessionDistanceInMeters, sessionAverageSpeed: sessionAverageSpeed, distanceSpeedChart: distanceSpeedChartValues, timeSpeedChart: timeSpeedChart, date: Date.now)

							// Stop Live activities
							guard let dateTimer else { return }
							let state = SessionActivityAttributes.ContentState(dateTimer: dateTimer)

							Task {
								await activity?.end(using: state, dismissalPolicy: .immediate)
							}
							self.dateTimer = nil

							// Start animate button from bottom to top
							self.endSessionAnimationButton = true
						}

						Button("Non", role: .cancel) {
							withAnimation(.easeIn(duration: 0.4)) {
								isSessionPaused = false
							}
						}
					}
			}

			.onAppear {
				motionManager.initializePodometer()
				locationManager.showAndUseBackgroundActivity = true

				// Start Live Activities
				dateTimer = .now
				guard dateTimer != nil else { return }
				let attribute = SessionActivityAttributes()
				let state = SessionActivityAttributes.ContentState(dateTimer: .now)

				activity = try? Activity<SessionActivityAttributes>.request(attributes: attribute, contentState: state, pushType: nil)
			}
			.onChange(of: motionManager.distance, perform: { distance in
				if let distance {
					if distance > 0 {
						sessionDistanceInMeters = distance
						self.distanceSpeedChartValues.append(
							DistanceSpeedChart(
								averageSpeed: sessionAverageSpeed,
								sessionDistance: sessionDistanceInMeters
							)
						)
					}
				}
			})
			.onDisappear {
				sessionTimer = 0
				sessionDistanceInMeters = 0
				sessionAverageSpeed = 0
				willStartTrainingSession = true
				isSessionPaused = false
				distanceSpeedChartValues = [DistanceSpeedChart]()
				timeSpeedChart = [TimeSpeedChart]()
				appInBackgroundSceneEpoch = 0
				appGoBackInActiveSceneEpoch = 0
				calculBackgroundTimePassed = 0
				dateTimer = nil
			}
			.onAppear {
				if locationManager.userLocation == nil {
					locationManager.requestLocation()
				}
				motionManager.initializePodometer()
			}
			.onChange(of: locationManager.userLocation, perform: {  location in
				if let location {
					if location.speed > 0 {
						finishedSesionVM.speedSessionValues.append(location.speed.turnMPerSecToKmPerH)
					}
					self.timeSpeedChart.append(TimeSpeedChart(time: sessionTimer, averageSpeed: location.speed.turnMPerSecToKmPerH))
				}
			})

			.onChange(of: motionManager.distance, perform: { distance in
				if let distance = motionManager.distance {
					sessionDistanceInMeters = distance
				}
			})
			.onReceive(timerPublisher.currentTimePublisher) { _ in
				if locationManager.userLocation != nil {
					sessionTimer += 1
				}
			}
			.navigationBarBackButtonHidden(true)
			.navigationBarTitleDisplayMode(.inline)
			.toolbarColorScheme((colorScheme == .dark ? .dark : .light), for: .navigationBar)

			.toolbarBackground(Color("toolbarColor"), for: .navigationBar)
			.toolbarBackground(.visible, for: .navigationBar)
		}
		.onChange(of: scenePhase) { newPhase in
			if newPhase == .inactive {
				print("Inactive")
			} else if newPhase == .active {
				print("Active")
				appGoBackInActiveSceneEpoch = Int(Date().timeIntervalSince1970)
				self.calculBackgroundTimePassed = ((appGoBackInActiveSceneEpoch - appInBackgroundSceneEpoch) / 60)
				sessionTimer += calculBackgroundTimePassed
			} else if newPhase == .background {
				print("Background")
				appInBackgroundSceneEpoch = Int(Date().timeIntervalSince1970)
			}
		}
	}
}

struct StartedSessionView_Previews: PreviewProvider {
	@Namespace static var nameSpace
	static var previews: some View {
		NavigationStack {
			StartedSessionView(
				session: .sample,
				sessionTimer: .constant(0),
				sessionDistanceInMeters: .constant(453),
				sessionAverageSpeed: .constant(3.45),
				isSessionPaused: .constant(false),
				distanceSpeedChartValues: .constant(DistanceSpeedChart.distanceSpeedArraySample),
				timeSpeedChart: .constant(TimeSpeedChart.timeSpeedArraySample),
				appInBackgroundSceneEpoch: .constant(0),
				appGoBackInActiveSceneEpoch: .constant(0),
				calculBackgroundTimePassed: .constant(0),
				willStartTrainingSession: .constant(false),
				nameSpace: nameSpace,
				dateTimer: .constant(.now),
				endSessionAnimationButton: .constant(false),
				startSessionAnimationButton: .constant(false)
			)
			.environmentObject(FinishedSessionViewModel())
			.environmentObject(ConvertTimeViewModel())
			.environmentObject(PlaySongViewModel())
			.environmentObject(CoreMotionViewModel())
			.environmentObject(LocationManager())
			.environmentObject(WeatherViewModel())
		}
	}
}

struct SessionInformation: View {
	var sfSymbol: String
	var objectif: String?
	var sessionValue: String
	var sessionValueFont: Font = Font.largeTitle.monospacedDigit().bold()
	var color: Color = .accentColor

	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			Image(systemName: sfSymbol)
				.font(.title)

			Text("\(sessionValue)")
				.font(sessionValueFont)
			if let objectif {
				Text("\(objectif)")
					.opacity(0.5)
					.font(.title3)
			}
		}
		.foregroundColor(color)
	}
}
