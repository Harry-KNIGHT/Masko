//
//  FinishedSessionListView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

struct FinishedSessionListView: View {
	@EnvironmentObject var finishedSessionVM: FinishedSessionViewModel
    var body: some View {
		List {
			ForEach(finishedSessionVM.fishishedSessions) { session in
				VStack(alignment: .leading) {
					Text("Objectif: \(session.timeObjectif) min")
					Text("Actual time: \(session.sessionTime) ")
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
		}
    }
}

struct FinishedSessionListView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedSessionListView()
			.environmentObject(FinishedSessionViewModel())
    }
}
