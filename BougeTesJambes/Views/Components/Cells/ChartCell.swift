//
//  ChartCell.swift
//  Masko
//
//  Created by Elliot Knight on 25/10/2022.
//

import SwiftUI
import Charts

struct ChartCell: View {
	let session: SessionModel
	var body: some View {
		if let timeSpeedChart = session.timeSpeedChart {
			VStack(alignment: .leading, spacing: 10) {
				Text("Temps / Vitesse")
					.foregroundColor(.primary)
					.font(.title2.bold())
				Chart(timeSpeedChart) { value in
					LineMark(
						x: .value("Temps", value.time),
						y: .value("Vitesse", value.averageSpeed)
					)

				}
				.chartXAxis {
					AxisMarks(values: .automatic) { value in
						AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
							.foregroundStyle(Color.primary)
						AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
							.foregroundStyle(Color.red)
						AxisValueLabel() {
							if let intValue = value.as(Int.self) {
								Text("\(intValue < 60 ? intValue : intValue / 60) \(intValue < 60 ? "sec" : "min")")
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
				.padding(.top, 10)
			}
		}
	}
}

struct ChartCell_Previews: PreviewProvider {
    static var previews: some View {
		ChartCell(session: .sample)
			.previewLayout(.sizeThatFits)
			.background(BackgroundLinearColor())
			.preferredColorScheme(.dark)
    }
}