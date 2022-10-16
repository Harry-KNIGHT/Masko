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
	@State private var showAlert: Bool = false

	var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
	@State private var sessionTimer: Int = 0
    var body: some View {
		VStack {
			List {
				VStack(alignment: .leading) {
					Text("Objectif: \(session.timeObjectif) min")
					Text("Actual time: \(sessionTimer) ")
				}

				VStack(alignment: .leading) {
					Text("Objectif: \(session.ditanceObjectifInKm) km")
					Text("Actual distance: \(session.sessionDistanceInKm) km  ")
				}

				VStack(alignment: .leading) {
					Text("Objectif: \(session.averageSpeedObjectif) km/k")
					Text("Actual speed: \(session.sessionAverageSpeed) km/h ")
				}
			}
			Button(action: {
				path.removeLast()
			}, label: {
				Text("go back to first vie")
			})

		}
		.onReceive(timer) { _ in
			sessionTimer += 1
		}
		.navigationBarBackButtonHidden(true)
    }
}

struct StartedSessionView_Previews: PreviewProvider {
    static var previews: some View {
		StartedSessionView(session: .sample, path: .constant(NavigationPath()))
    }
}
