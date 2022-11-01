//
//  SessionFinishedTextCell.swift
//  Masko
//
//  Created by Elliot Knight on 22/10/2022.
//

import SwiftUI

struct SessionFinishedTextCell: View {
	var icon: String?
	var value: String
	var font: Font = .body
	var body: some View {
		HStack {
			if let icon = icon {
				Image(systemName: icon)
			}
			Text(value)
		}
		.font(font)
	}
}

struct SessionFinishedTextCell_Previews: PreviewProvider {
	static var previews: some View {
		SessionFinishedTextCell(icon: "stopwatch", value: "00:34")
	}
}
