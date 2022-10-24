//
//  SessionFinishedListRow.swift
//  Masko
//
//  Created by Elliot Knight on 22/10/2022.
//

import SwiftUI

struct SessionFinishedListRow: View {
	let session: SessionModel
	@ObservedObject var convertTimeVM = ConvertTimeViewModel()

	var body: some View {
		VStack(alignment: .leading, spacing: 5) {

			SessionFinishedTextCell(value: session.sportType.sportName, font: .headline)

			SessionFinishedTextCell(icon: "stopwatch", value: "\(convertTimeVM.convertSecInTime(timeInSeconds: session.sessionTime))")

			SessionFinishedTextCell(icon: "flag", value: "\(String(format: "%.2f", session.sessionDistanceInMeters))km")

			SessionFinishedTextCell(icon: "speedometer", value: "\(String(format: "%.2f", session.sessionAverageSpeed))km/h")
		}
		.foregroundColor(.primary)
	}
}

struct SessionFinishedListRow_Previews: PreviewProvider {
    static var previews: some View {
		SessionFinishedListRow(session: .sample)
    }
}
