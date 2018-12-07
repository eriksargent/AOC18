//
//  Puzzle6.swift
//  AOC18Tests
//
//  Created by Erik Sargent on 12/6/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation
import XCTest

@testable import AOC18


class Puzzle6: XCTestCase {
	func testP1() {
		XCTAssertEqual(Puzzle6_1.solve(input: "1, 1\n1, 6\n8, 3\n3, 4\n5, 5\n8, 9"), "17")
	}
	
	func testP2() {
		Puzzle6_2.distanceThreshold = 32
		XCTAssertEqual(Puzzle6_2.solve(input: "1, 1\n1, 6\n8, 3\n3, 4\n5, 5\n8, 9"), "16")
	}
}
