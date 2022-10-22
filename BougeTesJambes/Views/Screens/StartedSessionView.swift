//
//  StartedSessionView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

struct StartedSessionView: View {
	let session: SessionModel
	@StateObject var locationManager = LocationManager()
	@StateObject var motionManager = CoreMotionViewModel()
	@Binding var path: NavigationPath
	@EnvironmentObject public var finishedSesionVM: FinishedSessionViewModel
	@EnvironmentObject public var convertTimeVM: ConvertTimeViewModel
	@ObservedObject public var convertLocValueVM = ConvertLocationValuesViewModel()
	@ObservedObject public var playSongVM = PlaySongViewModel()
	let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
	@State private var sessionTimer: Int = 0
	@State private var sessionDistanceInKm: Double = 0
	@State private var sessionAverageSpeed: Double = 0

	@State private var isSessionPaused: Bool = false
	@State private var distanceSpeedChartValues: [DistanceSpeedChart] = []

	@Environment(\.colorScheme) var colorScheme
	var body: some View {
		ZStack {
			BackgroundLinearColor()
			VStack {
				Spacer()

				SessionInformation(sfSymbol: "stopwatch", sessionValue: "\(String(convertTimeVM.convertSecInTime(timeInSeconds: sessionTimer)))")

				Spacer()
				HStack {

						SessionInformation(
							sfSymbol: "flag",
							sessionValue: "\(String(format: "%.2tf", sessionDistanceInKm)) \(sessionDistanceInKm > 1_000 ? "km" : "m")"
						)

					Spacer()
					if let location = locationManager.userLocation {
						SessionInformation(
							sfSymbol: "speedometer",
							sessionValue: "\( location.speed < 0 ? "0.00" : convertLocValueVM.convertMeterPerSecIntoKmHour(meterPerSec: location.speed))"
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

						self.finishedSesionVM.fishishedSessions.append(SessionModel(
							image: session.sportType,
							sportType: session.sportType,
							difficulty: nil,
							ditanceObjectifInKm: session.ditanceObjectifInKm,
							sessionTime: sessionTimer,
							sessionDistanceInKm: sessionDistanceInKm,
							sessionAverageSpeed: sessionAverageSpeed,
							distanceSpeedChart: distanceSpeedChartValues, date: nil)
						)
					}

					Button("Non", role: .cancel) {
						isSessionPaused = false
					}
				}
			}

			.onAppear {
				motionManager.initializePodometer()
			}
			.onChange(of: motionManager.distance, perform:  { distance in
				if let distance {
					if distance > 0 {
						sessionDistanceInKm = distance
							self.distanceSpeedChartValues.append(DistanceSpeedChart(averageSpeed: sessionAverageSpeed, sessionDistance: sessionDistanceInKm))
					}
				}
			})
			.onChange(of: locationManager.userLocation, perform: {  location in
				if let location {
					if location.speed > 0 {
						sessionAverageSpeed = location.speed
					}
				}
			})

			.onChange(of: motionManager.distance, perform: { distance in
				if let distance = motionManager.distance {
					sessionDistanceInKm = distance
				}
			})
			.onReceive(timer) { _ in
				sessionTimer += 1
			}
			.navigationBarBackButtonHidden(true)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .principal) {
					HStack {
						session.sportType.sportIcon
						Text(session.sportType.sportName)

					}
					.toolbarTitleStyle()
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					Text("\(String(session.ditanceObjectifInKm)) km")
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
	}
}

struct StartedSessionView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			StartedSessionView(session: .sample, path: .constant(NavigationPath()))
				.environmentObject(FinishedSessionViewModel())
				.environmentObject(ConvertTimeViewModel())
				.environmentObject(PlaySongViewModel())
				.environmentObject(ConvertLocationValuesViewModel())
		}
	}
}

struct SessionInformation: View {
	var sfSymbol: String
	var objectif: String?
	var sessionValue: String
	var color: Color = .primary

	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			Image(systemName: sfSymbol)
				.font(.title)

			Text("\(sessionValue)")
				.font(.largeTitle.bold())
			if let objectif {
				Text("\(objectif)")
					.opacity(0.5)
					.font(.title3)
			}
		}
		.foregroundColor(color)
	}
}
