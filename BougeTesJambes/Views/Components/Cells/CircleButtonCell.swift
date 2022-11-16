//
//  CircleButtonCell.swift
//  Masko
//
//  Created by Elliot Knight on 16/11/2022.
//

import SwiftUI

struct CircleButtonCell: View {
	private let buttonGradient = LinearGradient(
		colors: [
			Color("buttonTopColor"),
			Color("buttonMiddleTopColor"),
			Color("buttonMiddleBottomColor"),
			Color("buttonBottomColor")
		],
		startPoint: .top,
		endPoint: .bottom
	)

	var width: CGFloat
    var body: some View {
		Circle()
			.frame(width: width)
			.foregroundStyle(buttonGradient)
			.shadow(color: Color("buttonShadow"), radius: 10)
    }
}

struct CircleButtonCell_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonCell(width: 220)
    }
}
