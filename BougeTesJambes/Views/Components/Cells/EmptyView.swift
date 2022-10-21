//
//  EmptyView.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 18/10/2022.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
		ZStack {
			Color("viewBackgroundColor").ignoresSafeArea()
			VStack(spacing: 20) {
				Text("Aucune session finie.")

			}
			.foregroundColor(.white)
			.font(.largeTitle)
			.fontWeight(.semibold)
			.multilineTextAlignment(.center)
			.padding(.horizontal)

		}
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
