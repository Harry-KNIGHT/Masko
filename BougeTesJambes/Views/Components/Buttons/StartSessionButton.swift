//
//  StartSessionButton.swift
//  Masko
//
//  Created by Elliot Knight on 31/10/2022.
//

import SwiftUI

struct StartSessionButton: View {
	@Binding var willStartTrainingSession: Bool
	@State private var animationAmount: Double = 1
	var nameSpace: Namespace.ID
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
			.scaleEffect(animationAmount)

			.animation(
				.easeInOut(duration: 1.0)
				.repeatForever(autoreverses: true),
				value: animationAmount)
			.matchedGeometryEffect(id: "button", in: nameSpace, properties: .position)
		}
		.onAppear {
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
		StartSessionButton(willStartTrainingSession: .constant(false), nameSpace: nameSpace)
	}
}
