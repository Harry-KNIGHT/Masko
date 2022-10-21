//
//  TrainingsListView.swift
//  Masko
//
//  Created by Elliot Knight on 20/10/2022.
//

import SwiftUI
import WeatherKit

struct TrainingsListView: View {
	@StateObject var locationManager = LocationManager()
	@EnvironmentObject var weatherVM: WeatherViewModel
	@Environment(\.colorScheme) var colorScheme
    var body: some View {
		NavigationStack {
			ZStack {
				LinearGradient(colors: [Color(red: 16/255, green: 54/255, blue: 56/255), Color("viewBackgroundColor")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
				ScrollView(.vertical, showsIndicators: false) {
					ForEach(sessionPropositions) { session in
						SessionRecommandationRow(session: session)
							.shadow(color: Color("viewBackgroundColor") , radius: 5)
							.padding(10)
					}
				}
			}
			.navigationTitle("MASKO")


			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					HStack {
						if let weather = weatherVM.weather {
							Text(weather.currentWeather.temperature.description)
							Image(systemName: weather.currentWeather.symbolName)
						}
					}
					.foregroundColor(.white)
					.font(.headline)
				}
			}
			.toolbarColorScheme((colorScheme == .dark ? .dark : .light), for: .navigationBar)

			.toolbarBackground(Color("actionInteractionColor"), for: .navigationBar)
			.toolbarBackground(.visible, for: .navigationBar)
		}

		.task {
			if let location = locationManager.userLocation {
				await weatherVM.getWeather(lat: location.coordinate.latitude, long: location.coordinate.longitude)
			}
		}
    }
}

struct TrainingsListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsListView()
			.environmentObject(WeatherViewModel())
			.preferredColorScheme(.dark)
    }
}
