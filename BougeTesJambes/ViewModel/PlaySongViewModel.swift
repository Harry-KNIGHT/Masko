//
//  PlaySongViewModel.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import SwiftUI

import Foundation
import AVFoundation

class PlaySongViewModel: ObservableObject {
	var audioPlayer: AVAudioPlayer?
	let alertDoneSession: [String] = ["mixkit-arcade", "mixkit-happy", "mixkit-horror", "mixkit-service"]
	func playsong(sound: String, type: String) {
		let sound = alertDoneSession.randomElement()
		if let path = Bundle.main.path(forResource: sound, ofType: type) {
			do {
				audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
				audioPlayer?.play()
			} catch {
				print("Could not find file in bundle.")
			}
		}
	}
}
