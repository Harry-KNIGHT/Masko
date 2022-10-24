//
//  SelectSportButtonsView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 18/10/2022.
//

import SwiftUI

struct SelectSportButtonsCell: View {
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
							.foregroundColor(choice == sportChoosen ? Color("actionInteractionColor") : .gray)
							.shadow(color: choice == sportChoosen ? Color("actionInteractionColor").opacity(5) : .white.opacity(0),  radius: 5)
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

struct SelectSportButtonsCell_Previews: PreviewProvider {
	static var previews: some View {
		SelectSportButtonsCell(sportChoosen: .constant(.running))
			.previewLayout(.sizeThatFits)
	}
}
