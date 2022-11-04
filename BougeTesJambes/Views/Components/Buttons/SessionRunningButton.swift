//
//  SessionRunningButton.swift
//  Masko
//
//  Created by Elliot Knight on 21/10/2022.
//

import SwiftUI

struct SessionRunningButton: View {
	@Binding var isSessionPaused: Bool
	@State private var buttonWidth = 2.0
	var body: some View {
		ZStack {
			Circle()
				.frame(width: 100)
				.foregroundColor(Color("buttonColor"))
				.shadow(color: .accentColor, radius: 10)

			Image(systemName: isSessionPaused ? "play.fill" : "pause.fill")
				.font(.custom("", size: 60, relativeTo: .largeTitle))
				.foregroundColor(.white)
		}
		.scaleEffect(buttonWidth)
		.onAppear {
			withAnimation(.easeOut(duration: 0.7)) {
				buttonWidth = 1
			}
		}
		.onTapGesture {
			isSessionPaused = true
		}

	}
}

struct SessionRunningButton_Previews: PreviewProvider {
	@Namespace static var nameSpace
	static var previews: some View {
		SessionRunningButton(isSessionPaused: .constant(false))
	}
}
