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

	var nameSpace: Namespace.ID

	@Environment(\.colorScheme) var colorScheme
	@Environment(\.scenePhase) var scenePhase

	@EnvironmentObject var locationManager: LocationManager
	@EnvironmentObject var motionManager: CoreMotionViewModel
	@EnvironmentObject public var finishedSesionVM: FinishedSessionViewModel
	@EnvironmentObject public var convertTimeVM: ConvertTimeViewModel
	@EnvironmentObject var calculPaceVM: CalculPaceViewModel

	@ObservedObject public var playSongVM = PlaySongViewModel()

	@Binding var sessionTimer: Int
	@Binding var sessionDistanceInMeters: Double
	@Binding var sessionAverageSpeed: Double
	@Binding var sessionPace: Int
	@Binding var isSessionPaused: Bool
	@Binding var distanceSpeedChartValues: [DistanceSpeedChart]
	@Binding var timeSpeedChart: [TimeSpeedChart]
	@Binding var startSessionEpoch: Int?
	@Binding var willStartTrainingSession: Bool
	@Binding var dateTimer: Date?
	@Binding var endSessionAnimationButton: Bool
	@Binding var startSessionAnimationButton: Bool

	@State private var endSessionEpoch: Int?
	@State private var activity: Activity<SessionActivityAttributes>?
	@State private var paceUpperThanKilometerEpoch: Double?

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

					SessionInformationView(
						sfSymbol: "flag",
						objectif: "\(sessionDistanceInMeters > 1_000 ? "km" : "m")",
						sessionValue: "\(String(format: "%.2f", sessionDistanceInMeters.turnThousandMToKm))"
					)
					.accessibilityLabel("Distance parcourue")
					.accessibilityValue("\(sessionDistanceInMeters.turnThousandMToKm) \(sessionDistanceInMeters.turnThousandMToKm > 1_000 ? "kilomètres" : "mètres")")

					Spacer()

						SessionInformationView(
							sfSymbol: "speedometer",
							objectif: "min/km",
							sessionValue: "\(calculPaceVM.calculPace(startedSessionEpoch: Double(startSessionEpoch ?? 0), nowEpoch: (paceUpperThanKilometerEpoch ?? 0), meters: sessionDistanceInMeters))"
						)
						.accessibilityLabel("Pace indicator")
						// .accessibilityValue("\(motionManager.pace?.turnMperSecToKmPerMin ?? "0") kilomètre par minutes")

				}
				.padding(.horizontal)
				Spacer()

				SessionRunningButton(
					isSessionPaused: $isSessionPaused,
					startSessionAnimationButton: $startSessionAnimationButton,
					endSessionAnimationButton: $endSessionAnimationButton,
					willStartTrainingSession: $willStartTrainingSession,
					sessionTimer: $sessionTimer,
					startSessionEpoch: $startSessionEpoch,
					endSessionEpoch: $endSessionEpoch,
					sessionDistanceInMeters: $sessionDistanceInMeters,
					sessionAverageSpeed: $sessionAverageSpeed,
					sessionPace: $sessionPace,
					distanceSpeedChartValues: $distanceSpeedChartValues,
					timeSpeedChart: $timeSpeedChart
				)
				.matchedGeometryEffect(id: "button", in: nameSpace, properties: .position)
				.padding(.bottom, 30)
			}

			.onAppear {
				motionManager.initializePodometer()
				locationManager.showAndUseBackgroundActivity = true
			}
			.onChange(of: motionManager.distance, perform: { distance in
				if let distance {
					if distance > 0 {
						sessionDistanceInMeters = distance
					}
					if distance > 1_000 {
						paceUpperThanKilometerEpoch = Date().timeIntervalSince1970
					}
				}
			})

			.onChange(of: locationManager.userLocation) {  location in
				if let location {
					if location.speed > 0 {
						finishedSesionVM.speedSessionValues.append(location.speed.description.min(0, 100).turnMPerSecToKmPerH)
						finishedSesionVM.speedSessionValues.append(location.speed)
					}
				}
			}
			.onDisappear {
				sessionTimer = 0
				sessionDistanceInMeters = 0
				sessionAverageSpeed = 0
				willStartTrainingSession = true
				isSessionPaused = false
				distanceSpeedChartValues = []
				timeSpeedChart = []
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
				nameSpace: nameSpace, sessionTimer: .constant(0),
				sessionDistanceInMeters: .constant(453),
				sessionAverageSpeed: .constant(3),
				sessionPace: .constant(345),
				isSessionPaused: .constant(false),
				distanceSpeedChartValues: .constant(DistanceSpeedChart.distanceSpeedArraySample),
				timeSpeedChart: .constant(TimeSpeedChart.timeSpeedArraySample),
				startSessionEpoch: .constant(0),
				willStartTrainingSession: .constant(false),
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
			.environmentObject(CalculPaceViewModel())
		}
	}
}
