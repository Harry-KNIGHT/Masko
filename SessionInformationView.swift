//
//  SessionInformationView.swift
//  Masko
//
//  Created by Elliot Knight on 11/11/2022.
//

import SwiftUI

struct SessionInformationView: View {
	var sfSymbol: String
	var objectif: String?
	var sessionValue: String
	var sessionValueFont: Font = Font.largeTitle.monospacedDigit().bold()
	var color: Color = .accentColor

	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			Image(systemName: sfSymbol)
				.font(.title)

			Text("\(sessionValue)")
				.font(sessionValueFont)
				.fontDesign(.rounded)

			if let objectif {
				Text("\(objectif)")
					.opacity(0.5)
					.font(.title3)
					.fontDesign(.rounded)
			}
		}
		.foregroundColor(color)
	}
}

struct SessionInformationView_Previews: PreviewProvider {
	static var previews: some View {
		SessionInformationView(sfSymbol: "stopwatch", sessionValue: "243")
	}
}
