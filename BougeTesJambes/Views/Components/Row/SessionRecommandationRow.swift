//
//  SessionRecommandationRow.swift
//  Masko
//
//  Created by Elliot Knight on 20/10/2022.
//

import SwiftUI

struct SessionRecommandationRow: View {
	let session: SessionModel
	var body: some View {
		HStack(alignment: .top) {
			HStack(alignment: .center, spacing: 15) {
				if let image = session.sportType.sportImage {
					Image(image)
						.resizable()
						.scaledToFit()
						.frame(height: 150)
						.cornerRadius(15)
				} else {
					RoundedRectangle(cornerRadius: 15)
						.frame(height: 150)
				}
				VStack(alignment: .leading, spacing: 20) {
					Text(session.sportType.sportName)
						.font(.title2.bold())
					Text("\(session.ditanceObjectifInMeters.description) km")
						.font(.title3)
						.fontWeight(.medium)
					if let difficulty = session.difficulty?.difficultyName {
						Text(difficulty)
							.fontWeight(.semibold)
							.foregroundColor(.white)
							.padding(8)
							.background(Color("actionInteractionColor"))
							.cornerRadius(10)
					}
				}
			}
			Spacer()
			Image(systemName: session.sportType.sportIcon)
				.font(.title)
		}
		.foregroundColor(.primary)
		.padding(8)
		.background(.regularMaterial)
		.cornerRadius(15)

	}
}

struct SessionRecommandationRow_Previews: PreviewProvider {
	static var previews: some View {
		SessionRecommandationRow(session: .sample)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
	}
}
