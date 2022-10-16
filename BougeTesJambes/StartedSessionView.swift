//
//  StartedSessionView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

struct StartedSessionView: View {
	let session: SessionModel
	@Binding var path: NavigationPath
	@EnvironmentObject public var finishedSesionVM: FinishedSessionViewModel
	@EnvironmentObject public var convertTimeVM: ConvertTimeViewModel

	var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
	@State private var sessionTimer: Int = 0
	@State private var sessionDistanceInKm: Int = 2
	@State private var sessionAverageSpeed: Double = 5.6

    var body: some View {
		VStack {
			List {
				SessionInformation(objectif: String(session.timeObjectif), sessionValue: String(convertTimeVM.convertSecInTime(timeInSeconds: sessionTimer)))



				SessionInformation(objectif: String(session.ditanceObjectifInKm), sessionValue: String(sessionDistanceInKm))

				SessionInformation(objectif: String(session.averageSpeedObjectif), sessionValue: String(sessionAverageSpeed))

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
		.onReceive(timer) { _ in
			sessionTimer += 1
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
    }
}

struct SessionInformation: View {
	var objectif: String
	var sessionValue: String

	var body: some View {
		VStack(alignment: .leading) {
			Text("Objectif: \(objectif) min")
			Text("Actual time: \(sessionValue) ")
		}
	}
}
