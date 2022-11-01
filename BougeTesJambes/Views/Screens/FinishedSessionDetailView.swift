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
	var body: some View {
		List {
			FinishedSessionInformation(
				objectifType: "Temps",
				sessionInfo: "\(convertTimeVM.convertSecInTimeInListAndDetailView(timeInSec: session.sessionTime))",
				objectif: nil
			)

			FinishedSessionInformation(
				objectifType: "Distance",
				sessionInfo: "\(String(format: "%.2tf \(session.sessionDistanceInMeters > 1_000 ? "km" : "mètres")", session.sessionDistanceInMeters))",
				objectif: nil
			)

			FinishedSessionInformation(
				objectifType: "Vitesse moyenne",
				sessionInfo: "\(String(format: "%.2f km/h", session.sessionAverageSpeed))",
				objectif: nil
			)
			Section(header: Text("Temps / Vitesse")) {
				ChartCell(session: session)
			}
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
		}
	}
}

struct FinishedSessionInformation: View {
	var objectifType: String
	var sessionInfo: String
	var objectif: String?
	var body: some View {
		Section(header: Text(objectifType)) {
			if let objectif {
				Text("\(sessionInfo) / \(objectif)")
			} else {
				Text(sessionInfo)
			}
		}
	}
}
