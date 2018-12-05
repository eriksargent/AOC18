//
//  Puzzle.swift
//  AOC18
//
//  Created by Erik Sargent on 11/26/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


protocol Puzzle {
	static var name: String { get }
	static var day: Int { get }
	static var puzzle : Int { get }
	static func solve(input: String) -> String
}


extension Puzzle {
	static var name: String {
		return "Day \(day) - Puzzle \(puzzle)"
	}
}
