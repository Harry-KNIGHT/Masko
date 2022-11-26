//
//  FinishedSessionTests.swift
//  MaskoTests
//
//  Created by Elliot Knight on 02/11/2022.
//

import XCTest
@testable import Masko
final class FinishedSessionTests: XCTestCase {
	var sut: FinishedSessionViewModel!
    override func setUpWithError() throws {
        sut = FinishedSessionViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

	func test_addFinishedSession() {
		let session = SessionModel.sample

		guard let time = session.timeSpeedChart, let distance = session.distanceSpeedChart, let date = session.date else {
			return
		}

		let addSession: () = sut.addFinishedSession(
			sessionTime: session.sessionTime,
			sessionDistanceInMeters: session.sessionDistanceInMeters,
			sessionAverageSpeed: session.sessionAverageSpeed,
			pace: session.pace,
			distanceSpeedChart: distance,
			timeSpeedChart: time,
			date: date
		)

		XCTAssertNotNil(addSession)
	}

}
