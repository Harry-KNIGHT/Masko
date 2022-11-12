//
//  AppleWeatherTrademarkView.swift
//  Masko
//
//  Created by Elliot Knight on 12/11/2022.
//

import SwiftUI

struct AppleWeatherTrademarkView: View {
    var body: some View {
        Text(" Weather")
			.fontWeight(.semibold)
			.font(.subheadline)
			.foregroundColor(.accentColor)
			.opacity(0.6)
			.accessibilityHidden(true)

    }
}

struct AppleWeatherTrademarkView_Previews: PreviewProvider {
    static var previews: some View {
        AppleWeatherTrademarkView()
			.previewLayout(.sizeThatFits)
    }
}
