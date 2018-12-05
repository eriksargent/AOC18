//
//  Puzzle2.swift
//  AOC18Tests
//
//  Created by Erik Sargent on 12/2/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation
import XCTest

@testable import AOC18


class Puzzle2: XCTestCase {
	func testP1() {
		XCTAssertEqual(Puzzle2_1.solve(input: "abcdef\nbababc\nabbcde\nabcccd\naabcdd\nabcdee\nababab"), "12")
	}
	
	func testP2() {
		XCTAssertEqual(Puzzle2_2.solve(input: "abcdef\nbababc\nabbcde\nabcccd\naabcdd\nabcdee\nababab"), "abcde")
		XCTAssertEqual(Puzzle2_2.solve(input: "abcde\nfghij\nklmno\npqrst\nfguij\naxcye\nwvxyz"), "fgij")
	}
}
