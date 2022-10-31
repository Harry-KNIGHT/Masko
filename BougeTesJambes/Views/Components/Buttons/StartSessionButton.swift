//
//  StartSessionButton.swift
//  Masko
//
//  Created by Elliot Knight on 31/10/2022.
//

import SwiftUI

struct StartSessionButton: View {
	@Binding var willStartTrainingSession: Bool
	@Binding var animationAmount: Double
    var body: some View {
		VStack {
			Text("Appuie et fonce !")
				.fontWeight(.semibold)
				.font(.title)
				.foregroundColor(.accentColor)

			Button {
				willStartTrainingSession = false
			} label: {
				Image(systemName: "hare.fill")
				 .font(.custom("",size: 100, relativeTo: .largeTitle))
				 .foregroundColor(.white)
				 .padding(50)
				 .background(Color("buttonColor"))
				 .clipShape(Circle())
				 .shadow(color: .accentColor, radius: 10)
				 .scaleEffect(animationAmount)
				 .animation(
					.easeInOut(duration: 1.0)
					 .repeatForever(autoreverses: true),
					 value: animationAmount)
			}
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
    static var previews: some View {
		StartSessionButton(willStartTrainingSession: .constant(false), animationAmount: .constant(1))
    }
}
