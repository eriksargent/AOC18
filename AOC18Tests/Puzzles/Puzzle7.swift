//
//  Puzzle7.swift
//  AOC18Tests
//
//  Created by Erik Sargent on 12/6/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation
import XCTest

@testable import AOC18


class Puzzle7: XCTestCase {
	func testP1() {
		XCTAssertEqual(Puzzle7_1.solve(input: "Step C must be finished before step A can begin.\nStep C must be finished before step F can begin.\nStep A must be finished before step B can begin.\nStep A must be finished before step D can begin.\nStep B must be finished before step E can begin.\nStep D must be finished before step E can begin.\nStep F must be finished before step E can begin."), "CABDFE")
	}
	
	func testP2() {
		XCTAssertEqual(Puzzle7_2.solve(input: "Step C must be finished before step A can begin.\nStep C must be finished before step F can begin.\nStep A must be finished before step B can begin.\nStep A must be finished before step D can begin.\nStep B must be finished before step E can begin.\nStep D must be finished before step E can begin.\nStep F must be finished before step E can begin."), "15")
	}
}
