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

	@State private var pausedSession: Bool = false
	var body: some View {
		ZStack {
			Color("viewBackgroundColor").ignoresSafeArea()
			VStack {
				Spacer()

				SessionInformation(
					sfSymbol: "stopwatch", objectif: "\(String(session.timeObjectif))min",
					sessionValue: "\(String(convertTimeVM.convertSecInTime(timeInSeconds: sessionTimer)))"
				)
				.foregroundColor(convertTimeVM.compareConvertedTimeAndSessionTime(convertedSecInMin: session.timeObjectif, sessionTime: sessionTimer) == true ? .green : .primary)
				Spacer()
				HStack {
					if motionManager.isPedometerAvailable {
						SessionInformation(
							sfSymbol: "flag", objectif: "\(String(session.ditanceObjectifInKm))km",
							sessionValue: "\(String(format: "%.2tf \(sessionDistanceInKm > 1_000 ? "km" : "m")", sessionDistanceInKm))"
						)
					}
					Spacer()
					if let location = locationManager.userLocation {
						SessionInformation(
							sfSymbol: "speedometer", objectif: "\(String(session.averageSpeedObjectif))km/h",
							sessionValue: "\(convertLocValueVM.convertMeterPerSecIntoKmHour(meterPerSec: location.speed))"
						)
					}
				}
				.padding(.horizontal)
				Spacer()
				Button(action: {
					pausedSession = true
				}, label: {
					ZStack(alignment: .center) {
						Circle()
							.fill(Color("actionInteractionColor").gradient)
							.frame(height: 120)
							.shadow(color: Color("actionInteractionColor"), radius: 10)

						Image(systemName: pausedSession ? "play.fill" : "pause.fill")
							.font(.custom("",size: 60, relativeTo: .largeTitle))
							.foregroundColor(.white)
					}
				})
				.alert("Arrêter la session ?", isPresented: $pausedSession) {
					Button("Oui", role: .destructive) {
						path.removeLast()

						self.finishedSesionVM.fishishedSessions.append(SessionModel(sportType: session.sportType, timeObjectif: session.timeObjectif, ditanceObjectifInKm: session.ditanceObjectifInKm, averageSpeedObjectif: session.averageSpeedObjectif, sessionTime: sessionTimer, sessionDistanceInKm: sessionDistanceInKm, sessionAverageSpeed: sessionAverageSpeed))
					}
					Button("Non", role: .cancel) {
						pausedSession = false
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

				if convertTimeVM.isSessionTimeBiggerThanConvertedTime(sessionTime: sessionTimer, convertedSecInMin: session.timeObjectif) {
					playSongVM.playsong(sound: "mixkit-arcade", type: "wav")
				}
			}
			.navigationBarBackButtonHidden(true)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .principal) {
					HStack {
						session.sportType.sportIcon
						Text(session.sportType.sportName)

					}
					.foregroundColor(.white)
					.font(.title2.bold())
				}
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
				.environmentObject(ConvertLocationValuesViewModel())
		}
	}
}

struct SessionInformation: View {
	var sfSymbol: String
	var objectif: String
	var sessionValue: String

	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			Image(systemName: sfSymbol)
				.font(.title)

			Text("\(sessionValue)")
				.font(.largeTitle.bold())

			Text("\(objectif)")
				.opacity(0.5)
				.font(.title3)
		}.foregroundColor(.white)
	}
}
