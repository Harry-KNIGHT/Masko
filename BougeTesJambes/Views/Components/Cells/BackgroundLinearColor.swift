//
//  BackgroundLinearColor.swift
//  Masko
//
//  Created by Elliot Knight on 21/10/2022.
//

import SwiftUI

struct BackgroundLinearColor: View {
    var body: some View {
		LinearGradient(colors: [Color("topBackgroundColor"), Color("bottomBackgroundColor")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
    }
}

struct BackgroundLinearColor_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundLinearColor()
    }
}
