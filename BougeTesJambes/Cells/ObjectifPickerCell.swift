//
//  ObjectifPickerCell.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 18/10/2022.
//

import SwiftUI

struct ObjectifPickerCell: View {
	var objectifIndication: String
	@Binding var selection: Int
	var tillWhichNumber: Int
	var objectifMinKmOrSpeed: String
	var body: some View {
		HStack {
			Text(objectifIndication)
				.font(.title)
				.fontWeight(.medium)
			Spacer()
			Picker("Durée", selection: $selection) {
				ForEach(1..<tillWhichNumber, id: \.self) { time in
					Text("\(String(time))\(objectifMinKmOrSpeed)")
				}
			}
			.tint(Color("textActionColor"))
		}
	}
}

struct ObjectifPickerCell_Previews: PreviewProvider {
	static var previews: some View {
		ObjectifPickerCell(objectifIndication: "Durée", selection: .constant(20), tillWhichNumber: 30, objectifMinKmOrSpeed: "mn")
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
	}
}
