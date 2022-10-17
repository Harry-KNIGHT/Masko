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


	@StateObject var coreMotionManager = CoreMotionManager()

    var body: some View {
		NavigationStack(path: $path) {
			VStack {
				List {
					Picker("Session sport", selection: $sportChoosen) {
						ForEach(Sport.allCases, id: \.self) { sport in
							Text(sport.rawValue.capitalized)
						}
					}

					Picker("Time Objectif", selection: $timeObjectif) {
						ForEach(1..<60, id: \.self) { time in
							Text(String(time))
						}
					}
					Picker("Distance Objectif", selection: $ditanceObjectifInKm) {
						ForEach(1...10, id: \.self) { distance in
							Text(String(distance))
						}
					}

					Picker("Average speed objectif", selection: $averageSpeedObjectif) {
						ForEach(1...20, id: \.self) { speed in
							Text(String(speed))
						}
					}
				}

				NavigationLink(value: SessionModel(sportType: sportChoosen, timeObjectif: timeObjectif, ditanceObjectifInKm: ditanceObjectifInKm, averageSpeedObjectif: averageSpeedObjectif, sessionTime: sessionTimer, sessionDistanceInKm: Double(sessionDistanceInKm), sessionAverageSpeed: sessionAverageSpeed)) {
					ZStack {
						Text("Go !")
					}
				}
			}
			.navigationDestination(for: SessionModel.self) { session in
				StartedSessionView(session: SessionModel(sportType: sportChoosen, timeObjectif: timeObjectif, ditanceObjectifInKm: ditanceObjectifInKm, averageSpeedObjectif: averageSpeedObjectif, sessionTime: sessionTimer, sessionDistanceInKm: Double(sessionDistanceInKm), sessionAverageSpeed: sessionAverageSpeed), path: $path)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: {
						showSheet = true
					}, label: {
						Label("Show finished session", systemImage: "plus")
					})
					.sheet(isPresented: $showSheet) {
						FinishedSessionListView()
					}
				}
			}
			.navigationTitle("Start session")
			.onAppear {
				if locationManager.userLocation == nil {
					locationManager.requestLocation()
				}
				coreMotionManager.initializePodometer()
			}
		}
    }
}

struct StartSessionView_Previews: PreviewProvider {
    static var previews: some View {
		StartSessionView()
    }
}
