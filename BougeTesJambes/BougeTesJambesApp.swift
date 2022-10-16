//
//  BougeTesJambesApp.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

@main
struct BougeTesJambesApp: App {
	@StateObject public var finishedSessionVM = FinishedSessionViewModel()
    var body: some Scene {
        WindowGroup {
			StartSessionView()
				.environmentObject(finishedSessionVM)
        }
    }
}
