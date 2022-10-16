//
//  FinishedSessionListView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

struct FinishedSessionListView: View {
	@EnvironmentObject var finishedSessionVM: FinishedSessionViewModel
	@ObservedObject var convertLocValueVM = ConvertLocationValuesViewModel()
	@ObservedObject var convertTimeVM = ConvertTimeViewModel()
    var body: some View {
		NavigationStack {
			List {
				ForEach(finishedSessionVM.fishishedSessions) { session in
					NavigationLink(destination: FinishedSessionDetailView(session: session)) {
						VStack(alignment: .leading) {
							HStack {
								Text("\(convertTimeVM.convertSecInTime(timeInSeconds: session.sessionTime)) / ")
								Text("\(session.timeObjectif) min")

							}

							HStack {
								Text("\(session.sessionDistanceInKm) km / ")
								Text("\(session.ditanceObjectifInKm) km")

							}

							HStack {
								Text("\(session.averageSpeedObjectif) km/h / ")
								Text("\(convertLocValueVM.convertMeterPerSecIntoKmHour(meterPerSec: session.sessionAverageSpeed))")
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
			.environmentObject(ConvertLocationValuesViewModel())
			.environmentObject(ConvertTimeViewModel())
    }
}
