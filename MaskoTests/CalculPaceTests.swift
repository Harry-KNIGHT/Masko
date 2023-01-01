//
//  CalculPaceTests.swift
//  MaskoTests
//
//  Created by Elliot Knight on 01/01/2023.
//

import XCTest
@testable import Masko

final class CalculPaceTests: XCTestCase {
	var paceVM: CalculPaceViewModel!
    override func setUpWithError() throws {
		paceVM = CalculPaceViewModel()
    }

    override func tearDownWithError() throws {
		paceVM = nil
    }

	func test_no_pace_calcul() throws {
		let meters: Double = 750

		let input = paceVM.calculPace(
			startedSessionEpoch: Date().timeIntervalSince1970 - 55,
			nowEpoch: Date().timeIntervalSince1970,
			meters: meters
		)

		XCTAssertEqual(input, "00:00")
	}

	func test_twoKM_pace_calul() throws {
		let meters: Double = 2_000

		let startSessionEpoch: Double = 1672584900 // Sunday, 1 January 2023 14:55:00
		let nowEpoch1: Double = 1672585200 // Sunday, 1 January 2023 15:00:00

		let nowEpoch2: Double = 1672585800 // Sunday, 1 January 2023 15:10:00

		let input1 = paceVM.calculPace(
			startedSessionEpoch: startSessionEpoch,
			nowEpoch: nowEpoch1,
			meters: meters
		)

		let input2 = paceVM.calculPace(
			startedSessionEpoch: startSessionEpoch,
			nowEpoch: nowEpoch2,
			meters: meters
		)

		// 1km made in 02:30 min
		XCTAssertEqual(input1, "02:30")
		XCTAssertNotEqual(input1, "2:30")

		// 1km made in 07:30 min
		XCTAssertEqual(input2, "07:30")
		XCTAssertNotEqual(input2, "00:00")
	}
}
