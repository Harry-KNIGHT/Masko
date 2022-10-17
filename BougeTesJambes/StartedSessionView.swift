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
	@StateObject var motionManager = CoreMotionManager()
	@Binding var path: NavigationPath
	@EnvironmentObject public var finishedSesionVM: FinishedSessionViewModel
	@EnvironmentObject public var convertTimeVM: ConvertTimeViewModel
	@ObservedObject public var convertLocValueVM = ConvertLocationValuesViewModel()
	@ObservedObject public var playSongVM = PlaySongViewModel()
	let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
	@State private var sessionTimer: Int = 0
	@State private var sessionDistanceInKm: Double = 0
	@State private var sessionAverageSpeed: Double = 1
	@StateObject public var coreMotionManager = CoreMotionManager()
    var body: some View {
		VStack {
			List {
				SessionInformation(
					objectif: "\(String(session.timeObjectif))min",
					sessionValue: "\(String(convertTimeVM.convertSecInTime(timeInSeconds: sessionTimer)))"
				)
					.foregroundColor(convertTimeVM.compareConvertedTimeAndSessionTime(convertedSecInMin: session.timeObjectif, sessionTime: sessionTimer) == true ? .green : .primary)

				if coreMotionManager.isPedometerAvailable {
					SessionInformation(
						objectif: "\(String(session.ditanceObjectifInKm))km",
						sessionValue: "Session distance: \(String(format: "%.2tf \(sessionDistanceInKm > 1_000 ? "km" : "m")", sessionDistanceInKm))"
					)
				} else {
					Text("Go !")
				}

					if let location = locationManager.userLocation {
						SessionInformation(
							objectif: "\(String(session.averageSpeedObjectif))km/h",
							sessionValue: "User Speed: \(convertLocValueVM.convertMeterPerSecIntoKmHour(meterPerSec: location.speed))"
						)
				}
			}

			Button(action: {
				path.removeLast()

				self.finishedSesionVM.fishishedSessions.append(SessionModel(sportType: session.sportType, timeObjectif: session.timeObjectif, ditanceObjectifInKm: session.ditanceObjectifInKm, averageSpeedObjectif: session.averageSpeedObjectif, sessionTime: sessionTimer, sessionDistanceInKm: sessionDistanceInKm, sessionAverageSpeed: sessionAverageSpeed))
			}, label: {
				Text("go back to first view")
					.padding()
			})
			.backgroundStyle(.blue)

		}
		.onAppear {
			motionManager.initializePodometer()
		}
		.onChange(of: motionManager.distance, perform:  { distance in
			if let distance {
				sessionDistanceInKm = distance
			}
		})
		.onChange(of: locationManager.userLocation, perform: {  location in
			if let location {
				if location.speed > 0 {
					sessionAverageSpeed = location.speed
				}
			}
		})

		.onChange(of: coreMotionManager.distance, perform: { distance in
			if let distance = coreMotionManager.distance {
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
		.toolbar {
			ToolbarItem(placement: .principal) {
				Text(session.sportType.rawValue)
			}
		}
    }

}

struct StartedSessionView_Previews: PreviewProvider {
    static var previews: some View {
		StartedSessionView(session: .sample, path: .constant(NavigationPath()))
			.environmentObject(FinishedSessionViewModel())
			.environmentObject(ConvertTimeViewModel())
			.environmentObject(PlaySongViewModel())
			.environmentObject(ConvertLocationValuesViewModel())
    }
}

struct SessionInformation: View {
	var objectif: String
	var sessionValue: String

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("\(objectif)")
				.foregroundColor(.secondary)
			Text("\(sessionValue)")
				.font(.headline)
		}
	}
}
