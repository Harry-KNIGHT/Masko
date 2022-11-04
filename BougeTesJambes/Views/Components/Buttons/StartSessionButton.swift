//
//  StartSessionButton.swift
//  Masko
//
//  Created by Elliot Knight on 31/10/2022.
//

import SwiftUI

struct StartSessionButton: View {
	@Binding var willStartTrainingSession: Bool
	@State private var animationAmount: CGFloat = 1
	@State private var buttonWidth: CGFloat = 0.5
	var nameSpace: Namespace.ID
	@Binding var endSessionAnimationButton: Bool
	var body: some View {
		VStack {
			Text("Appuie et fonce !")
				.fontWeight(.semibold)
				.font(.title)
				.foregroundColor(.accentColor)
			ZStack {
				Circle()
					.frame(width: 220)
					.foregroundColor(Color("buttonColor"))
					.shadow(color: .accentColor, radius: 10)

				Image(systemName: "hare.fill")
					.font(.custom("", size: 100, relativeTo: .largeTitle))
					.foregroundColor(.white)
			}
			.scaleEffect(endSessionAnimationButton ? 0.5 : animationAmount)

			.animation(
				.easeInOut(duration: 1.0)
				.repeatForever(autoreverses: true),
				value: animationAmount)
			.matchedGeometryEffect(id: "button", in: nameSpace, properties: .position)
		}
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
				if endSessionAnimationButton {
					endSessionAnimationButton = false
					print(endSessionAnimationButton)
				}
			}
			animationAmount = 1.035
		}
		.onDisappear {
			animationAmount = 1
		}
	}
}

struct StartSessionButton_Previews: PreviewProvider {
	@Namespace static var nameSpace
	static var previews: some View {
		StartSessionButton(willStartTrainingSession: .constant(false), nameSpace: nameSpace, endSessionAnimationButton: .constant(false))
	}
}
