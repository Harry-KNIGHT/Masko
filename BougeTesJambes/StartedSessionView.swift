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
	@Binding var path: NavigationPath
	@EnvironmentObject public var finishedSesionVM: FinishedSessionViewModel
	@EnvironmentObject public var convertTimeVM: ConvertTimeViewModel
	@ObservedObject public var playSongVM = PlaySongViewModel()
	let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
	@State private var sessionTimer: Int = 0
	@State private var sessionDistanceInKm: Int = 2
	@State private var sessionAverageSpeed: Double = 5.6

    var body: some View {
		VStack {
			List {
				SessionInformation(objectif: "Temps obj: \(String(session.timeObjectif))min", sessionValue: "Actual time \(String(convertTimeVM.convertSecInTime(timeInSeconds: sessionTimer)))")
					.foregroundColor(convertTimeVM.compareConvertedTimeAndSessionTime(convertedSecInMin: session.timeObjectif, sessionTime: sessionTimer) == true ? .green : .primary)

				SessionInformation(objectif: "Distance obj: \(String(session.ditanceObjectifInKm))km", sessionValue: "Session distance: \(String(sessionDistanceInKm))")


					if let location = locationManager.userLocation {
						SessionInformation(objectif: "Speed obj: \(String(session.averageSpeedObjectif))km/h", sessionValue: "Session speed: \(String(format: "%.2f", location.speed * 3.6))")
					
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
		.onChange(of: locationManager.userLocation, perform: {  location in
			if let location {
				if location.speed > 0 {
					sessionAverageSpeed = location.speed
				}
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
    }
}

struct SessionInformation: View {
	var objectif: String
	var sessionValue: String

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("\(objectif)")
			Text("\(sessionValue)")
		}
	}
}
