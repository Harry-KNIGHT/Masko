//
//  SessionRunningButton.swift
//  Masko
//
//  Created by Elliot Knight on 21/10/2022.
//

import SwiftUI

struct SessionRunningButton: View {
	@State private var buttonWidth = 2.0
	@Binding var isSessionPaused: Bool
	@State private var buttonSymbol: String = "hare.fill"
	@Binding var startSessionAnimationButton: Bool
	@Binding var endSessionAnimationButton: Bool
	@EnvironmentObject var locationManager: LocationManager
	@EnvironmentObject var finishedSesionVM: FinishedSessionViewModel
	@Binding var willStartTrainingSession: Bool
	@Binding var sessionTimer: Int
	@Binding var startSessionEpoch: Int?
	@Binding var endSessionEpoch: Int?
	@Binding var sessionDistanceInMeters: Double
	@Binding var sessionAverageSpeed: Double
	@Binding var distanceSpeedChartValues: [DistanceSpeedChart]
	@Binding var timeSpeedChart: [TimeSpeedChart]

	var body: some View {
		ZStack {
			CircleButtonCell(width: 100)

			Image(systemName: startSessionAnimationButton ? "hare.fill" : isSessionPaused ? "play.fill" : "pause.fill")
				.font(.custom("", size: 60, relativeTo: .largeTitle))
				.foregroundColor(.white)
		}
		.alert("Arrêter la session ?", isPresented: $isSessionPaused) {
			Button("Oui", role: .destructive) {

				locationManager.showAndUseBackgroundActivity = false
				withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
					willStartTrainingSession = true
				}

				self.endSessionAnimationButton = true
				endSessionEpoch = Int(Date().timeIntervalSince1970)

				if let endSessionEpoch, let startSessionEpoch {
					sessionTimer = (endSessionEpoch - startSessionEpoch)
				}
				print("Session was \(sessionTimer) time")

				self.finishedSesionVM.addFinishedSession(
					sessionTime: sessionTimer,
					sessionDistanceInMeters: sessionDistanceInMeters,
					sessionAverageSpeed: sessionAverageSpeed,
					distanceSpeedChart: distanceSpeedChartValues,
					timeSpeedChart: timeSpeedChart, date: Date.now
				)

				startSessionEpoch = nil
				endSessionEpoch = nil

			}
			.accessibilityLabel("Oui, arrêter l'entrainement")

			Button("Non", role: .cancel) {
				withAnimation(.easeIn(duration: 0.4)) {
					isSessionPaused = false
				}
			}
			.accessibilityLabel("Non, continuer l'entrainement en cours")
		}

		.accessibilityLabel("Mettre la session en pause")
		.scaleEffect(isSessionPaused ? buttonWidth + 0.134 : buttonWidth)
		.onAppear {
			withAnimation(.easeOut(duration: 0.7)) {
				buttonWidth = 1
			}
			withAnimation(.easeOut(duration: 0.8)) {
				startSessionAnimationButton = false
			}
		}

		.onTapGesture {
			withAnimation(.easeOut(duration: 0.4)) {
				isSessionPaused = true
			}
		}
	}
}

struct SessionRunningButton_Previews: PreviewProvider {
	@Namespace static var nameSpace
	static var previews: some View {
		SessionRunningButton(
			isSessionPaused: .constant(false),
			startSessionAnimationButton: .constant(false),
			endSessionAnimationButton: .constant(false),
			willStartTrainingSession: .constant(true),
			sessionTimer: .constant(130),
			startSessionEpoch: .constant(3454310),
			endSessionEpoch: .constant(3454332),
			sessionDistanceInMeters: .constant(1_453),
			sessionAverageSpeed: .constant(23.5),
			distanceSpeedChartValues: .constant(DistanceSpeedChart.distanceSpeedArraySample),
			timeSpeedChart: .constant(TimeSpeedChart.timeSpeedArraySample)

		)
		.environmentObject(LocationManager())
		.environmentObject(FinishedSessionViewModel())
	}
}
