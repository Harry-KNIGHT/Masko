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



	@Binding var timeSpeedChart: [TimeSpeedChart]

	@Environment(\.colorScheme) var colorScheme
	@Environment(\.scenePhase) var scenePhase

	@State private var startSessionEpoch: Int?
	@State private var endSessionEpoch: Int?

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
				if let dateTimer {
					VStack(spacing: 10) {
						Image(systemName: "stopwatch")
							.font(.title)

						Text(dateTimer, style: .timer)

							.font(Font.largeTitle.monospacedDigit().bold())
							.fontDesign(.rounded)
					}
					.foregroundColor(.accentColor)
				}
				Spacer()
				HStack {

					SessionInformation(
						sfSymbol: "flag",
						objectif: "\(sessionDistanceInMeters > 1_000 ? "km" : "m")",
						sessionValue: "\(String(format: "%.2f", sessionDistanceInMeters.turnThousandMToKm))"
					)
					.accessibilityLabel("Distance parcourue")
					.accessibilityValue("\(sessionDistanceInMeters.turnThousandMToKm) \(sessionDistanceInMeters.turnThousandMToKm > 1_000 ? "kilomètres" : "mètres")")

					Spacer()
					if let location = locationManager.userLocation {
						SessionInformation(
							sfSymbol: "speedometer",
							objectif: "km/h",
							sessionValue: "\(location.speed > 0 ? location.speed.twoDecimalDigits : "0.00")"
						)
						.accessibilityLabel("Vitesse de déplacement")
						.accessibilityValue("\(location.speed.turnMPerSecToKmPerH) kilomètres par heure")
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

							self.endSessionAnimationButton = true

						}
						.accessibilityLabel("Oui, arrêter l'entrainement")

						Button("Non", role: .cancel) {
							withAnimation(.easeIn(duration: 0.4)) {
								isSessionPaused = false
							}
						}
						.accessibilityLabel("Non, continuer l'entrainement en cours")
					}
			}

			.onAppear {
				motionManager.initializePodometer()
				locationManager.showAndUseBackgroundActivity = true
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
			.onChange(of: locationManager.userLocation) {  location in
				if let location {
					if location.speed > 0 {
						finishedSesionVM.speedSessionValues.append(location.speed.description.min(0, 100).turnMPerSecToKmPerH)
					}
					self.timeSpeedChart.append(TimeSpeedChart(time: sessionTimer, averageSpeed: sessionAverageSpeed))

				}
			}
			.onDisappear {
				sessionTimer = 0
				sessionDistanceInMeters = 0
				sessionAverageSpeed = 0
				willStartTrainingSession = true
				isSessionPaused = false
				distanceSpeedChartValues = [DistanceSpeedChart]()
				timeSpeedChart = [TimeSpeedChart]()
				startSessionEpoch = nil
				endSessionEpoch = nil
				dateTimer = nil
			}
			.navigationBarBackButtonHidden(true)
			.navigationBarTitleDisplayMode(.inline)
			.toolbarColorScheme((colorScheme == .dark ? .dark : .light), for: .navigationBar)

			.toolbarBackground(Color("toolbarColor"), for: .navigationBar)
			.toolbarBackground(.visible, for: .navigationBar)
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
				.fontDesign(.rounded)

			if let objectif {
				Text("\(objectif)")
					.opacity(0.5)
					.font(.title3)
 					.fontDesign(.rounded)
			}
		}
		.foregroundColor(color)
	}
}
