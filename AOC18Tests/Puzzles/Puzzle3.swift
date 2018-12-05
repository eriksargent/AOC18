//
//  Puzzle3.swift
//  AOC18Tests
//
//  Created by Erik Sargent on 12/3/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation
import XCTest

@testable import AOC18


class Puzzle3: XCTestCase {
	func testDay1() {
		XCTAssertEqual(Puzzle3_1.solve(input: "#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2"), "4")
	}
	
	func testDay2() {
		XCTAssertEqual(Puzzle3_2.solve(input: "#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2"), "3")
	}
}
