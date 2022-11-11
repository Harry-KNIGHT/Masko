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
				.fontDesign(.rounded)
				.foregroundColor(.accentColor)
			ZStack {
				Circle()
					.frame(width: 220)
					.foregroundColor(Color("buttonColor"))
					.shadow(color: Color("buttonShadow"), radius: 10)

				Image(systemName: endSessionAnimationButton ? "play.fill" : "hare.fill")
					.font(.custom("", size: 100, relativeTo: .largeTitle))
					.foregroundColor(.white)
			}
			.accessibilityLabel("Bouton pour démarrer une session de course ou de marche.")
			.scaleEffect(endSessionAnimationButton ? 0.5 : animationAmount)

			.animation(
				.easeInOut(duration: 1.0)
				.repeatForever(autoreverses: true),
				value: animationAmount)
			.matchedGeometryEffect(id: "button", in: nameSpace, properties: .position)
		}
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now()) {
				if endSessionAnimationButton {
					withAnimation(.easeOut(duration: 0.455)) {
						endSessionAnimationButton = false
					}
				}
				animationAmount = 1.033

			}
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
/*
 .onAppear {
 DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
 if endSessionAnimationButton {
 withAnimation {
 endSessionAnimationButton = false
 }
 }
 }
 withAnimation(.easeOut(duration: 0.7)) {
 if endSessionAnimationButton {
 animationAmount = 1
 } else {
 animationAmount = 1.035
 }

 }
 }
 */
