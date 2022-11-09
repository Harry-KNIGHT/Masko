//
//  MaskoLiveActivityWidgetLiveActivity.swift
//  MaskoLiveActivityWidget
//
//  Created by Elliot Knight on 02/11/2022.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SessionTrackingWidgetView: View {
	let context: ActivityViewContext<SessionActivityAttributes>
	var body: some View {
		Text("Test 1")
	}
}

struct MaskoLiveActivityWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SessionActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
			VStack(alignment: .leading, spacing: 6) {

				LiveActivityViewInfomation(
					sfSymbol: "figure.walk",
					sessionValue: context.state.sessionDistanceDone.twoDecimalDigits,
					objectifType: "m"
				)

				LiveActivityViewInfomation(
					sfSymbol: "flag.fill",
					sessionValue: context.state.sessionSpeed.turnMPerSecToKmPerH.twoDecimalDigits,
					objectifType: "km/h"
				)
			}
			.padding()
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
					VStack(alignment: .leading, spacing: 6) {
						Spacer()
						LiveActivityViewInfomation(
							sfSymbol: nil,
							sessionValue: context.state.sessionDistanceDone.turnThousandMToKm.twoDecimalDigits,
							objectifType: "\(context.state.sessionDistanceDone >= 1_000 ? "km" : "m")"
						)
						LiveActivityViewInfomation(
							sfSymbol: nil,
							sessionValue: "\(context.state.sessionSpeed.turnMPerSecToKmPerH.twoDecimalDigits.min(0, 100))",
							objectifType: "km/h"
						)
						Spacer()
					}
                }
                DynamicIslandExpandedRegion(.trailing) {
					VStack {
						Spacer()
						withAnimation {
							Image(systemName: context.state.sessionSpeed.turnMPerSecToKmPerH > 6 ? "figure.run" : "figure.walk")
								.font(.system(size: 50))
						}
						Spacer()
					}
					.padding()
                }
                DynamicIslandExpandedRegion(.bottom) {
                    // more content
                }
            } compactLeading: {
				Image(systemName: "hare.fill")
            } compactTrailing: {
				Text(context.state.sessionDistanceDone.twoDecimalDigits)

            } minimal: {
				Image(systemName: "hare.fill")
            }
        }
    }
}

struct LiveActivityViewInfomation: View {
	var sfSymbol: String?
	var sessionValue: String
	var objectifType: String
	var sessionValueFont: Font = Font.title2.monospacedDigit().bold()

	var body: some View {
		HStack(alignment: .bottom) {
			if let sfSymbol {
				Image(systemName: sfSymbol)
					.font(.title3)
			}
			Text("\(sessionValue)")
				.font(sessionValueFont)
				.fontDesign(.rounded)

				Text("\(objectifType)")
					.opacity(0.8)
					.font(.title3)
					.fontDesign(.rounded)
		}
	}
}
