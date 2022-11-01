//
//  SessionRunningButton.swift
//  Masko
//
//  Created by Elliot Knight on 21/10/2022.
//

import SwiftUI

struct SessionRunningButton: View {
	@Binding var isSessionPaused: Bool
	var nameSpace: Namespace.ID
	var body: some View {
			Image(systemName: isSessionPaused ? "play.fill" : "pause.fill")
				.font(.custom("", size: 60, relativeTo: .largeTitle))
				.foregroundColor(.white)
				.padding(30)
				.background(Color("buttonColor"))
				.clipShape(Circle())
				.shadow(color: .accentColor, radius: 10)
				.matchedGeometryEffect(id: "button", in: nameSpace)

				.onTapGesture {
					withAnimation {
						isSessionPaused = true
					}
				}

		}
}

struct SessionRunningButton_Previews: PreviewProvider {
	@Namespace static var nameSpace
	static var previews: some View {
		SessionRunningButton(isSessionPaused: .constant(false), nameSpace: nameSpace)

	}
}
