//
//  FinishedSessionDetailView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI
import Charts

struct FinishedSessionDetailView: View {
	let session: SessionModel
	@ObservedObject public var convertTimeVM = ConvertTimeViewModel()
	@Environment(\.colorScheme) var colorScheme
	@EnvironmentObject var paceVM: CalculPaceViewModel
	@EnvironmentObject var finishedSessionVM: FinishedSessionViewModel
	var body: some View {
		List {
			FinishedSessionInformationCell(
				objectifType: "Temps",
				sessionInfo: "\(convertTimeVM.convertSecInTimeInListAndDetailView(timeInSec: session.sessionTime))"
			)

			FinishedSessionInformationCell(
				objectifType: "Distance",
				sessionInfo: "\(session.sessionDistanceInMeters.isKmOrMtwoDigits)"
			)

			FinishedSessionInformationCell(
				objectifType: "Vitesse moyenne",
				sessionInfo: "\(String(format: "%.2f km/h", session.sessionAverageSpeed))"
			)

			FinishedSessionInformationCell(objectifType: "Pace", sessionInfo: "\(paceVM.finalPace(sessionTime: session.sessionTime, meters: session.sessionDistanceInMeters))")
		}
		.listStyle(.plain)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .principal) {
				if let date = session.date {
					Text(convertTimeVM.convertDateFormat(date: date))
						.fontWeight(.semibold)
				}
			}
		}
	}
}

struct FinishedSessionDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			FinishedSessionDetailView(session: .sample)
				.environmentObject(ConvertTimeViewModel())
				.environmentObject(CalculPaceViewModel())
				.environmentObject(FinishedSessionViewModel())
		}
	}
}
