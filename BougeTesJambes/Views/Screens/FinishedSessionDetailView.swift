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
		ScrollView {
			VStack(alignment: .leading) {
				FinishedSessionInformation(
					objectifType: "Temps",
					sessionInfo: "\(convertTimeVM.convertSecInTime(timeInSeconds: session.sessionTime))",
					objectif: nil
				)

				FinishedSessionInformation(
					objectifType: "Distance",
					sessionInfo: "\(String(format: "%.2tf \(session.ditanceObjectifInMeters > 1_000 ? "km" : "mètres")", session.sessionDistanceInMeters))",
					objectif: nil
				)


				FinishedSessionInformation(
					objectifType: "Vitesse",
					sessionInfo: "\(String(format: "%.2f", session.sessionAverageSpeed.turnMPerSecToKmPerH))km/h",
					objectif: nil
				)
				ChartCell(session: session)
					.padding()
					.background(.ultraThickMaterial)
					.cornerRadius(15)
			}
			.padding()
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle(session.sportType.sportName)

			.toolbarColorScheme((colorScheme == .dark ? .dark : .light), for: .navigationBar)

			.toolbarBackground(Color("toolbarColor"), for: .navigationBar)
			.toolbarBackground(.visible, for: .navigationBar)
		}
		.background(BackgroundLinearColor())
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
		HStack {
			VStack(alignment: .leading, spacing: 10) {
				Text(objectifType)
					.font(.title3.bold())
				if let objectif {
					Text("\(sessionInfo) / \(objectif)")
				} else {
					Text(sessionInfo)
				}
			}
			.foregroundColor(.primary)
			.padding(10)
			Spacer()

		}
		.background(.ultraThickMaterial)
		.cornerRadius(15)
	}
}


