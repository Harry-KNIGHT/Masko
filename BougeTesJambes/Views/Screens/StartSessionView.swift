//
//  StartSessionView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI
import CoreMotion

struct StartSessionView: View {
	@StateObject var locationManager = LocationManager()
	@State private var path = NavigationPath()

	@State private var sportChoosen: Sport = .running
	@State private var timeObjectif: Int = 1
	@State private var ditanceObjectifInKm: Int = 5
	@State private var averageSpeedObjectif: Int = 5


	@State private var sessionTimer: Int = 0
	@State private var sessionDistanceInKm: Int = 0
	@State private var sessionAverageSpeed: Double = 1

	@State private var showSheet: Bool = false


	@StateObject var coreMotionManager = CoreMotionViewModel()

	var body: some View {
		NavigationStack(path: $path) {
			ZStack {
				Color("viewBackgroundColor").ignoresSafeArea()
				VStack {

					SelectSportButtonsCell(sportChoosen: $sportChoosen)
						.padding()
					VStack {
						HStack {
							Text("Objectifs")
								.fontWeight(.semibold)
								.font(.largeTitle)
							Spacer()
						}

						ObjectifPickerCell(objectifIndication: "Durée", selection: $timeObjectif, tillWhichNumber: 30, objectifMinKmOrSpeed: "min")

						ObjectifPickerCell(objectifIndication: "Distance", selection: $ditanceObjectifInKm, tillWhichNumber: 20, objectifMinKmOrSpeed: "km")

						ObjectifPickerCell(objectifIndication: "Vitesse", selection: $averageSpeedObjectif, tillWhichNumber: 20, objectifMinKmOrSpeed: "km/h")
					}
					.padding(.horizontal)
					Spacer()
					NavigationLink(value: SessionModel(sportType: sportChoosen, timeObjectif: timeObjectif, ditanceObjectifInKm: ditanceObjectifInKm, averageSpeedObjectif: averageSpeedObjectif, sessionTime: sessionTimer, sessionDistanceInKm: Double(sessionDistanceInKm), sessionAverageSpeed: sessionAverageSpeed, distanceSpeedChart: nil)) {
						ZStack {
							Circle()
								.fill(Color("actionInteractionColor").gradient)
								.frame(height: 120)
								.shadow(color: Color("actionInteractionColor"), radius: 10)
							sportChoosen.sportIcon
								.font(.custom("",size: 60, relativeTo: .largeTitle))
								.foregroundColor(.white)


						}
					}
				}
				.foregroundColor(.white)
				.navigationDestination(for: SessionModel.self) { session in
					StartedSessionView(session: SessionModel(sportType: sportChoosen, timeObjectif: timeObjectif, ditanceObjectifInKm: ditanceObjectifInKm, averageSpeedObjectif: averageSpeedObjectif, sessionTime: sessionTimer, sessionDistanceInKm: Double(sessionDistanceInKm), sessionAverageSpeed: sessionAverageSpeed, distanceSpeedChart: nil), path: $path)
				}
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						ShowFinishedSessionSheetButtonCell(showSheet: $showSheet)
					}
					ToolbarItem(placement: .principal) {
						Text("Nouvelle session")
							.toolbarTitleStyle()
					}
				}
				.navigationBarTitleDisplayMode(.inline)
				.onAppear {
					if locationManager.userLocation == nil {
						locationManager.requestLocation()
					}
					coreMotionManager.initializePodometer()
				}
			}
		}
	}
}

struct StartSessionView_Previews: PreviewProvider {
	static var previews: some View {
		StartSessionView()
	}
}
