//
//  SelectSportButtonsView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 18/10/2022.
//

import SwiftUI

struct SelectSportButtonsView: View {
	@Binding var sportChoosen: Sport
    var body: some View {
		HStack {
			ForEach(Sport.allCases, id: \.self) { choice in
				Button(action: {
					sportChoosen = choice
				}, label: {
					ZStack(alignment: .center) {
						RoundedRectangle(cornerRadius: 10, style: .circular)
							.frame(height: 50)
							.foregroundColor(choice == sportChoosen ? .blue : .gray)
							.shadow(color: choice == sportChoosen ? .blue : .white.opacity(0),  radius: 7)
						Text(choice.sportName)
							.foregroundColor(.white)
							.font(.title3.bold())
							.padding(10)
					}
				})
			}
		}
    }
}

struct SelectSportButtonsView_Previews: PreviewProvider {
    static var previews: some View {
		SelectSportButtonsView(sportChoosen: .constant(.running))
			.previewLayout(.sizeThatFits)
    }
}
