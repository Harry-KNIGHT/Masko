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

					SelectSportButtonsView(sportChoosen: $sportChoosen)
						.padding()
					VStack {
						HStack {
							Text("Objectifs")
								.fontWeight(.semibold)
								.font(.largeTitle)
							Spacer()
						}

						HStack {
							Text("Durée")
								.font(.title)
								.fontWeight(.medium)
							Spacer()
							Picker("Durée", selection: $timeObjectif) {
								ForEach(1..<60, id: \.self) { time in
									Text("\(String(time))min")
								}
							}
							.tint(Color("textActionColor"))
						}
						HStack {
							Text("Distance")
								.font(.title)
								.fontWeight(.medium)

							Spacer()
							Picker("Distance", selection: $ditanceObjectifInKm) {
								ForEach(1...10, id: \.self) { distance in
									Text("\(String(distance))km")
								}
							}
							.tint(Color("textActionColor"))
						}

						HStack {
							Text("Vitesse")
								.font(.title)
								.fontWeight(.medium)

							Spacer()
							Picker("Vitesse", selection: $averageSpeedObjectif) {
								ForEach(1...20, id: \.self) { speed in
									Text("\(String(speed))km/h")
								}
							}
							.tint(Color("textActionColor"))
						}
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
						Button(action: {
							showSheet = true
						}, label: {
							Label("Show finished session", systemImage: "trophy.fill")
								.font(.title2)
								.foregroundColor(Color("textActionColor"))

						})
						.sheet(isPresented: $showSheet) {
							FinishedSessionListView()
						}
					}
					ToolbarItem(placement: .principal) {
						Text("Nouvelle session")
							.foregroundColor(.white)
							.fontWeight(.semibold)
							.font(.title2)
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
