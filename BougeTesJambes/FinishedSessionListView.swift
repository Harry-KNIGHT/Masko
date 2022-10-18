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
						VStack(alignment: .leading, spacing: 5) {
							Text(session.sportType.sportName)
								.font(.headline)
								.padding(.bottom, 6)
							Text("\(convertTimeVM.convertSecInTime(timeInSeconds: session.sessionTime))min")

							Text("\(String(format: "%.2f", session.sessionDistanceInKm))km")

							Text("\(session.averageSpeedObjectif)km/h")

						}
					}
					.listRowBackground(Color("actionInteractionColor"))
				}
			}
			.background(Color("viewBackgroundColor"))
			.scrollContentBackground(.hidden)
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("Sessions finies")
						.foregroundColor(.white)
						.fontWeight(.semibold)
						.font(.title2)
				}
			}
			.toolbarBackground(Color("viewBackgroundColor"), for: .navigationBar)
		}
	}
}

struct FinishedSessionListView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			FinishedSessionListView()
				.environmentObject(FinishedSessionViewModel())
				.environmentObject(ConvertLocationValuesViewModel())
				.environmentObject(ConvertTimeViewModel())
		}
	}
}
