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
		VStack(alignment: .leading) {
			Text("Temps")
				.font(.title)

				Text("Temps: \(convertTimeVM.convertSecInTime(timeInSeconds: session.sessionTime)) / \(session.timeObjectif)min")


			Text("Distance")
				.font(.title)

				Text("Distance: \(session.sessionDistanceInKm) / \(session.averageSpeedObjectif)")


			Text("Vitesse")
				.font(.title)

				Text("Vitesse: \(convertLocValueVM.convertMeterPerSecIntoKmHour(meterPerSec: session.sessionAverageSpeed)) / \(session.averageSpeedObjectif)")
		}
    }
}

struct FinishedSessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
		FinishedSessionDetailView(session: .sample)
			.environmentObject(ConvertLocationValuesViewModel())
			.environmentObject(ConvertTimeViewModel())
    }
}
