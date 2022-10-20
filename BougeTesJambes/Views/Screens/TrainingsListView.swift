//
//  TrainingsListView.swift
//  Masko
//
//  Created by Elliot Knight on 20/10/2022.
//

import SwiftUI

struct TrainingsListView: View {
    var body: some View {
		ZStack {
			LinearGradient(colors: [Color(red: 16/255, green: 54/255, blue: 56/255), Color("viewBackgroundColor")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
			ScrollView(.vertical, showsIndicators: false) {
				ForEach(sessionPropositions) { session in
					SessionRecommandationRow(session: session)
						.shadow(color: Color("viewBackgroundColor") , radius: 5)
						.padding(10)
				}
			}
		}
    }
}

struct TrainingsListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingsListView()
    }
}
