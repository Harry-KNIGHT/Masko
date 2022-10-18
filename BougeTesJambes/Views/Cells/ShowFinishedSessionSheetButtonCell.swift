//
//  ShowFinishedSessionSheetButtonCell.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 18/10/2022.
//

import SwiftUI

struct ShowFinishedSessionSheetButtonCell: View {
	@Binding var showSheet: Bool
	@ObservedObject var finishedSessionVM = FinishedSessionViewModel()
    var body: some View {
		Button(action: {
			showSheet = true
		}, label: {
			Label("Show finished session", systemImage: "trophy.fill")
				.font(.title2)
				.foregroundColor(Color("textActionColor"))

		})
		.sheet(isPresented: $showSheet) {
			if finishedSessionVM.fishishedSessions.isEmpty {
				EmptyView()
			} else {
				FinishedSessionListView()
			}
		}
    }
}

struct ShowFinishedSessionSheetButtonCell_Previews: PreviewProvider {
    static var previews: some View {
		ShowFinishedSessionSheetButtonCell(showSheet: .constant(false))
			.preferredColorScheme(.dark)
			.previewLayout(.sizeThatFits)
    }
}
