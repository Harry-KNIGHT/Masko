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
	@ObservedObject public var convertLocValueVM = ConvertLocationValuesViewModel()
	@ObservedObject public var convertTimeVM = ConvertTimeViewModel()
	@Environment(\.colorScheme) var colorScheme
	var body: some View {
			List {
				FinishedSessionInformation(
					objectifType: "Temps",
					sessionInfo: "\(convertTimeVM.convertSecInTime(timeInSeconds: session.sessionTime))",
					objectif: nil
				)



				FinishedSessionInformation(
					objectifType: "Distance",
					sessionInfo: "\(String(format: "%.2tf \(session.ditanceObjectifInKm > 1_000 ? "km" : "mètres")", session.sessionDistanceInKm))",
					objectif: nil
				)


				FinishedSessionInformation(
					objectifType: "Vitesse",
					sessionInfo: "\(convertLocValueVM.convertMeterPerSecIntoKmHour(meterPerSec: session.sessionAverageSpeed))",
					objectif: nil
				)
				Section("Distance / Vitesse") {
				if let distanceSpeedChart = session.distanceSpeedChart {
						Chart(distanceSpeedChart) { value in
							LineMark(
								x: .value("distance", value.sessionDistance),
								y: .value("vitesse", value.averageSpeed)
							)
							.foregroundStyle(.primary)

						}
						.chartYScale(domain: .automatic(includesZero: false))
						.chartXAxis {
							AxisMarks(values: .automatic) { value in
								AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
									.foregroundStyle(Color.cyan)
								AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
									.foregroundStyle(Color.red)
								AxisValueLabel() {
									if let intValue = value.as(Int.self) {
										Text("\(intValue) \(intValue > 1_000 ? "km" : "m")")
											.font(.system(size: 10)) // style it
											.foregroundColor(.primary)
									}
								}
							}
						}
						.chartYAxis {
							AxisMarks(values: .automatic) { value in
								AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
									.foregroundStyle(Color.primary)
								AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
									.foregroundStyle(Color.red)
								AxisValueLabel() { // construct Text here
									if let intValue = value.as(Int.self) {
										Text("\(intValue)km/h")
											.font(.system(size: 10)) // style it
											.foregroundColor(.primary)
									}
								}
							}
						}
					.frame(height: 250)
					}
				}
				Spacer()
			}
			

		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .principal) {
				HStack {
					session.sportType.sportIcon
					Text(session.sportType.sportName)
				}
				.foregroundColor(.primary)
				.toolbarTitleStyle()
			}
		}
		.toolbarColorScheme((colorScheme == .dark ? .dark : .light), for: .navigationBar)

		.toolbarBackground(Color("toolbarColor"), for: .navigationBar)
		.toolbarBackground(.visible, for: .navigationBar)

		
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
	var objectif: String?
	var body: some View {
		Section(objectifType) {
				VStack(alignment: .leading, spacing: 10) {
					if let objectif {
						Text("\(sessionInfo) / \(objectif)")
					} else {
						Text(sessionInfo)
					}
				}
				.foregroundColor(.primary)
				.padding(.vertical, 10)
		}
	}
}

