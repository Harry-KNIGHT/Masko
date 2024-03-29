//
//  LocationManager.swift
//  BougeTesJambes
//
//  Created by Elliot Knight on 16/10/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
	private let manager = CLLocationManager()
	@Published public var userLocation: CLLocation?
	static let shared = LocationManager()
	@Published public var showAndUseBackgroundActivity = false {
		didSet {
			manager.allowsBackgroundLocationUpdates = showAndUseBackgroundActivity
		}
	}
	override init() {
		super.init()
				manager.delegate = self
				manager.desiredAccuracy = kCLLocationAccuracyBest
				manager.startUpdatingLocation()
				manager.showsBackgroundLocationIndicator = showAndUseBackgroundActivity
				manager.allowsBackgroundLocationUpdates = showAndUseBackgroundActivity
	}

	func requestLocation() {
		manager.requestWhenInUseAuthorization()
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .notDetermined:
			print("DEBUG: Not determined")
		case .restricted:
			print("DEBUG: Auth restricted")
		case .denied:
			print("DEBUG: Auth denied")
		case .authorizedAlways:
			print("DEBUG: Auth always")
		case .authorizedWhenInUse:
			print("DEBUG: Auth when in use")
		case .authorized:
			print("DEBUG: Not determined")
		@unknown default:
			break
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		self.userLocation = location
	}
}
