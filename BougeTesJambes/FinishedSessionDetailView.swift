//
//  FinishedSessionDetailView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

struct FinishedSessionDetailView: View {
	let session: SessionModel
    var body: some View {
		VStack(alignment: .leading) {
			Text("Temps")
				.font(.title)
			HStack {
				Text("Temps: \(session.sessionTime) / \(session.timeObjectif)")
			}
			Text("Distance")
				.font(.title)
			HStack {
				Text("Distance: \(session.sessionDistanceInKm) / \(session.averageSpeedObjectif)")
			}

			Text("Vitesse")
				.font(.title)
			HStack {
				Text("Vitesse: \(session.sessionAverageSpeed) / \(session.averageSpeedObjectif)")
			}
		}
    }
}

struct FinishedSessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
		FinishedSessionDetailView(session: .sample)
    }
}
