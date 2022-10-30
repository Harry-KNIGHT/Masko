//
//  FinishedSessionListView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

struct FinishedSessionListView: View {
	@EnvironmentObject var finishedSessionVM: FinishedSessionViewModel
	@ObservedObject var convertTimeVM = ConvertTimeViewModel()
	var body: some View {
		NavigationStack {
			List {
				ForEach(finishedSessionVM.fishishedSessions) { session in
					NavigationLink(destination: FinishedSessionDetailView(session: session)) {
						Text(session.sessionTime.description)
					}
				}
			}
			.scrollContentBackground(.hidden)
			.background(BackgroundLinearColor())
			.scrollContentBackground(.hidden)
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("Sessions finies")
						.toolbarTitleStyle()
				}
			}
			.toolbarBackground(Color("toolbarColor"), for: .navigationBar)
		}
	}
}

struct FinishedSessionListView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			FinishedSessionListView()
				.environmentObject(FinishedSessionViewModel())
				.environmentObject(ConvertTimeViewModel())
		}
	}
}
