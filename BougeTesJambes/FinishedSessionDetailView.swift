//
//  FinishedSessionDetailView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

struct FinishedSessionDetailView: View {
	let session: SessionModel
	@ObservedObject public var convertLocValueVM = ConvertLocationValuesViewModel()
	@ObservedObject public var convertTimeVM = ConvertTimeViewModel()
    var body: some View {
		List {
			FinishedSessionInformation(
				objectifType: "Temps",
				sessionInfo: "\(convertTimeVM.convertSecInTime(timeInSeconds: session.sessionTime))",
				objectif: "\(session.timeObjectif / 60)min")

			FinishedSessionInformation(
				objectifType: "Distance",
				sessionInfo: "\(String(format: "%.2tf", session.sessionDistanceInKm))",
				objectif: "\(session.averageSpeedObjectif)km")

			FinishedSessionInformation(
				objectifType: "Vitesse",
				sessionInfo: "\(convertLocValueVM.convertMeterPerSecIntoKmHour(meterPerSec: session.sessionAverageSpeed))",
				objectif: "\(session.averageSpeedObjectif)km/h")

		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .principal) {
				HStack {
					session.sportType.sportIcon
					Text(session.sportType.sportName)
				}
				.font(.title2.bold())
			}
		}
    }
}

struct FinishedSessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			FinishedSessionDetailView(session: .sample)
				.environmentObject(ConvertLocationValuesViewModel())
				.environmentObject(ConvertTimeViewModel())
		}
    }
}

struct FinishedSessionInformation: View {
	var objectifType: String
	var sessionInfo: String
	var objectif: String
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(objectifType)
				.font(.title2)
			Text("\(sessionInfo) / \(objectif)")

		}
	}
}

