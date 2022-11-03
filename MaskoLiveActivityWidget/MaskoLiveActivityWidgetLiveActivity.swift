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
	let context: ActivityViewContext<SessionAtributes>
	var body: some View {
		Text("Test 1")
	}
}

struct MaskoLiveActivityWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SessionAtributes.self) { context in
            // Lock screen/banner UI goes here
			Text(context.state.dateTimer, style: .timer)

            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
					Text(context.state.dateTimer, style: .timer)
                }
                DynamicIslandExpandedRegion(.trailing) {
					Text(context.state.dateTimer, style: .timer)
                }
                DynamicIslandExpandedRegion(.bottom) {
					Text(context.state.dateTimer, style: .timer)
                    // more content
                }
            } compactLeading: {
				Image(systemName: "hare.fill")
            } compactTrailing: {
				Text(context.state.dateTimer, style: .timer)

            } minimal: {
				Image(systemName: "hare.fill")
            }
        }
    }
}
