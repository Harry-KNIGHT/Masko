//
//  FinishedSessionInformationCell.swift
//  Masko
//
//  Created by Elliot Knight on 13/11/2022.
//

import SwiftUI

struct FinishedSessionInformationCell: View {
	var objectifType: String
	var sessionInfo: String

	var body: some View {
		Section(header: Text(objectifType)) {
			Text(sessionInfo)
		}
	}
}

struct FinishedSessionInformationCell_Previews: PreviewProvider {
	static var previews: some View {
		FinishedSessionInformationCell(objectifType: "km", sessionInfo: "34")
	}
}
