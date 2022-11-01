//
//  ToolbarTitleViewModifier.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 18/10/2022.
//

import SwiftUI

struct ToolbarTitleStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.foregroundColor(.primary)
			.fontWeight(.semibold)
			.font(.title2)
	}
}

extension View {
	func toolbarTitleStyle() -> some View {
		modifier(ToolbarTitleStyle())
	}
}
