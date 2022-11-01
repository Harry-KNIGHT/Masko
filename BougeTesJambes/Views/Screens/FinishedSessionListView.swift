//
//  FinishedSessionListView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

struct FinishedSessionListView: View {
	@EnvironmentObject var finishedSessionVM: FinishedSessionViewModel
	@ObservedObject var convertTimeVM = ConvertTimeViewModel()
	var body: some View {
		NavigationStack {
			List {
				ForEach(finishedSessionVM.fishishedSessions) { session in
					NavigationLink(destination: FinishedSessionDetailView(session: session)) {
						VStack(alignment: .leading, spacing: 5) {
							if let sessionDate = session.date {
								Text(convertTimeVM.convertDateFormat(date: sessionDate))
									.fontWeight(.semibold)
									.font(.title3)
							}
							Text(convertTimeVM.convertSecInTimeInListAndDetailView(timeInSec: session.sessionTime))
							Text("\(String(format: "%.2f", session.sessionAverageSpeed)) km/h")
							Text("\(String(format: "%.2f", session.sessionDistanceInMeters))\(session.sessionDistanceInMeters > 1000 ? "km" : "m")")
						}
					}
				}
			}
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("Sessions finies")
						.toolbarTitleStyle()
				}
			}
		}
	}
}

struct FinishedSessionListView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			FinishedSessionListView()
				.environmentObject(FinishedSessionViewModel())
				.environmentObject(ConvertTimeViewModel())
		}
	}
}
