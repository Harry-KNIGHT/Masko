//
//  ConvertTimeTests.swift
//  BougeTesJambesTests
//
//  Created by Elliot Knight on 16/10/2022.
//

import XCTest
@testable import BougeTesJambes
final class ConvertTimeTests: XCTestCase {
	var sut: ConvertTimeViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		 sut = ConvertTimeViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		sut = nil
    }

	func test_convertSecInMin() {
		// Given
		let firstInput = 1
		let secondInput = 2

		// When
		let oneSecondTurnedIntoSixty = sut.convertSecInMin(second: firstInput)
		let oneSeconTunedIntoTwoMinInSec = sut.convertSecInMin(second: secondInput)

		// Then

		XCTAssertEqual(oneSecondTurnedIntoSixty, 60)
		XCTAssertNotEqual(oneSecondTurnedIntoSixty, oneSeconTunedIntoTwoMinInSec)

	}

}
