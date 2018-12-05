//
//  Puzzle1.swift
//  AOC18Tests
//
//  Created by Erik Sargent on 12/1/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation
import XCTest

@testable import AOC18


class Puzzle1: XCTestCase {
	func testP1() {
		XCTAssertEqual(Puzzle1_1.solve(input: "+1, -2, +3, +1"), "3")
		XCTAssertEqual(Puzzle1_1.solve(input: "+1, +1, +1"), "3")
		XCTAssertEqual(Puzzle1_1.solve(input: "+1, +1, -2"), "0")
		XCTAssertEqual(Puzzle1_1.solve(input: "-1, -2, -3"), "-6")
	}
	
	func testP2() {
		XCTAssertEqual(Puzzle1_2.solve(input: "+1, -2, +3, +1"), "2")
		XCTAssertEqual(Puzzle1_2.solve(input: "+1, -1"), "0")
		XCTAssertEqual(Puzzle1_2.solve(input: "+3, +3, +4, -2, -4"), "10")
		XCTAssertEqual(Puzzle1_2.solve(input: "-6, +3, 8, +5, -6"), "5")
		XCTAssertEqual(Puzzle1_2.solve(input: "+7, +7, -2, -7, -4"), "14")
	}
}
