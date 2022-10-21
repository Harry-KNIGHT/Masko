//
//  SessionRunningButton.swift
//  Masko
//
//  Created by Elliot Knight on 21/10/2022.
//

import SwiftUI

struct SessionRunningButton: View {
	@Binding var isSessionPaused: Bool
	var body: some View {
		Button(action: {
			isSessionPaused = true
		}, label: {
			ZStack(alignment: .center) {
				Circle()
					.fill(Color("actionInteractionColor"))

					.frame(height: 120)
					.shadow(color: Color("actionInteractionColor"), radius: 10)

				Image(systemName: isSessionPaused ? "play.fill" : "pause.fill")
					.font(.custom("",size: 60, relativeTo: .largeTitle))
					.foregroundColor(.white)
			}
		})
	}
}

struct SessionRunningButton_Previews: PreviewProvider {
	static var previews: some View {
		SessionRunningButton(isSessionPaused: .constant(false))
	}
}
