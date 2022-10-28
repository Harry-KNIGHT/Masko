//
//  StartedSessionView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

struct StartedSessionView: View {
	let session: SessionModel
	@EnvironmentObject var locationManager: LocationManager
	@EnvironmentObject var motionManager: CoreMotionViewModel
	@Binding var path: NavigationPath
	@EnvironmentObject public var finishedSesionVM: FinishedSessionViewModel
	@EnvironmentObject public var convertTimeVM: ConvertTimeViewModel

	@ObservedObject public var playSongVM = PlaySongViewModel()

	@State private var sessionTimer: Int = 0
	@State private var sessionDistanceInMeters: Double = 0
	@State private var sessionAverageSpeed: Double = 0

	@State private var isSessionPaused: Bool = false
	@State private var distanceSpeedChartValues: [DistanceSpeedChart] = []

	@StateObject var timerPublisher = SessionTimer()

	@State private var timeSpeedChart = [TimeSpeedChart]()

	@Environment(\.colorScheme) var colorScheme
	@Environment(\.scenePhase) var scenePhase

	@State private var appInBackgroundSceneEpoch: Int = 0
	@State private var appGoBackInActiveSceneEpoch: Int = 0
	@State private var calculBackgroundTimePassed: Int = 0
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
						sessionValue: "\(String(format: "%.1f", sessionDistanceInMeters.turnThousandMToKm))"
					)

					Spacer()
					if let location = locationManager.userLocation {
						SessionInformation(
							sfSymbol: "speedometer",
							objectif: "km/h",
							sessionValue: "\( location.speed < 0 ? "0.00" : String(format: "%.1f", location.speed.turnMPerSecToKmPerH))"
						)
						
					}
				}
				.padding(.horizontal)
				Spacer()

				SessionRunningButton(isSessionPaused: $isSessionPaused)
				
					.padding(.bottom, 30)
					.alert("Arrêter la session ?", isPresented: $isSessionPaused) {
						Button("Oui", role: .destructive) {
							path.removeLast()

							locationManager.showAndUseBackgroundActivity = false

							self.finishedSesionVM.fishishedSessions.insert(
								SessionModel(
									image: session.sportType,
									sportType: session.sportType,
									difficulty: nil,
									ditanceObjectifInMeters: session.ditanceObjectifInMeters,
									sessionTime: sessionTimer,
									sessionDistanceInMeters: sessionDistanceInMeters,
									sessionAverageSpeed: sessionAverageSpeed,
									distanceSpeedChart: distanceSpeedChartValues,
									timeSpeedChart: timeSpeedChart,
									date: nil
								),
								at: 0
							)
						}

						Button("Non", role: .cancel) {
							isSessionPaused = false
						}
					}
			}

			.onAppear {
				motionManager.initializePodometer()
				locationManager.showAndUseBackgroundActivity = true
			}
			.onChange(of: motionManager.distance, perform:  { distance in
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
			.onAppear {
				if locationManager.userLocation == nil {
					locationManager.requestLocation()
				}
				motionManager.initializePodometer()
			}
			.onChange(of: locationManager.userLocation, perform: {  location in
				if let location {
					if location.speed > 0 {
						sessionAverageSpeed = location.speed
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
			.toolbar {
				ToolbarItem(placement: .principal) {
					HStack {
						Image(systemName: session.sportType.sportIcon)
						Text(session.sportType.sportName)

					}
					.toolbarTitleStyle()
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					Text("\(String(session.ditanceObjectifInMeters)) km")
						.fontWeight(.semibold)
						.font(.title2)
						.foregroundColor(.primary)
						.padding(5)
						.background(.thinMaterial)
						.cornerRadius(10)
				}
			}
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
	static var previews: some View {
		NavigationStack {
			StartedSessionView(session: .sample, path: .constant(NavigationPath()))
				.environmentObject(FinishedSessionViewModel())
				.environmentObject(ConvertTimeViewModel())
				.environmentObject(PlaySongViewModel())
				.environmentObject(CoreMotionViewModel())
				.environmentObject(LocationManager())
		}
	}
}

struct SessionInformation: View {
	var sfSymbol: String
	var objectif: String?
	var sessionValue: String
	var sessionValueFont: Font = Font.largeTitle.monospacedDigit().bold()
	var color: Color = .primary

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
