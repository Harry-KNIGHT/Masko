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
		NavigationStack {
			List {
				ForEach(finishedSessionVM.fishishedSessions) { session in
					NavigationLink(destination: FinishedSessionDetailView(session: session)) {
						VStack(alignment: .leading) {
							HStack {
								Text("\(session.timeObjectif) min / ")
								Text("\(session.sessionTime) min")
							}

							HStack {
								Text("\(session.ditanceObjectifInKm) km / ")
								Text("\(session.sessionDistanceInKm) km  ")
							}

							HStack {
								Text("\(session.averageSpeedObjectif) km/h / ")
								Text("\(session.sessionAverageSpeed) km/h ")
							}
						}
					}
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
