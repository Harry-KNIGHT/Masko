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
	var body: some View {
		ZStack {
			Color("viewBackgroundColor").ignoresSafeArea()
			ScrollView(.vertical, showsIndicators: false) {
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
				
					if let distanceSpeedChart = session.distanceSpeedChart {
						Chart(distanceSpeedChart) { value in
							LineMark(
								x: .value("distance", value.sessionDistance),
								y: .value("vitesse", value.averageSpeed)
							)
							.foregroundStyle(Color("textActionColor"))

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
											.foregroundColor(.white)
									}
								}
							}
						}
						.chartYAxis {
							AxisMarks(values: .automatic) { value in
								AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
									.foregroundStyle(Color.cyan)
								AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
									.foregroundStyle(Color.red)
								AxisValueLabel() { // construct Text here
									if let intValue = value.as(Int.self) {
										Text("\(intValue)km/h")
											.font(.system(size: 10)) // style it
											.foregroundColor(.white)
									}
								}
							}
						}
						.frame(height: 250)
					}
				Spacer()

			}
			.padding(.top)
		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .principal) {
				HStack {
					session.sportType.sportIcon
					Text(session.sportType.sportName)
				}
				.foregroundColor(.white)
				.fontWeight(.semibold)
				.font(.title2)
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
		HStack {
			VStack(alignment: .leading, spacing: 10) {
				Text(objectifType)
					.font(.title2)
				Text("\(sessionInfo) / \(objectif)")
			}
			.foregroundColor(.white)
			.padding(.vertical, 10)
			Spacer()
		}
		.padding(.horizontal)

	}
}

