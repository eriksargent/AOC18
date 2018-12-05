//
//  Puzzle5.swift
//  AOC18Tests
//
//  Created by Erik Sargent on 12/5/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation
import XCTest

@testable import AOC18


class Puzzle5: XCTestCase {
	func testP1() {
		XCTAssertEqual(Puzzle5_1.solve(input: "aA"), "0")
		XCTAssertEqual(Puzzle5_1.solve(input: "abBA"), "0")
		XCTAssertEqual(Puzzle5_1.solve(input: "abAB"), "4")
		XCTAssertEqual(Puzzle5_1.solve(input: "aabAAB"), "6")
		XCTAssertEqual(Puzzle5_1.solve(input: "dabAcCaCBAcCcaDA"), "10")
	}
	
	func testP2() {
		XCTAssertEqual(Puzzle5_2.solve(input: "dabAcCaCBAcCcaDA"), "4")
	}
}
