//
//  AppTabView.swift
//  Masko
//
//  Created by Elliot Knight on 30/10/2022.
//

import SwiftUI

struct AppTabView: View {
	var body: some View {
		TabView {
			LaunchSessionView()
				.tabItem {
					Label("S'entrainer !", systemImage: "plus")
				}
			
			FinishedSessionListView()
				.tabItem {
					Label("Sessions finies", systemImage: "minus")
				}
		}
	}
}

struct AppTabView_Previews: PreviewProvider {
	static var previews: some View {
		AppTabView()
	}
}
