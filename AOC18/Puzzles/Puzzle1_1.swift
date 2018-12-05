//
//  Puzzle1_1.swift
//  AOC18
//
//  Created by Erik Sargent on 11/26/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle1_1: Puzzle {
	static let day = 1
	static let puzzle = 1
	
	static func solve(input: String) -> String {
		let comps = input.components(separatedBy: CharacterSet(charactersIn: ",").union(.whitespacesAndNewlines))
		let freqs = comps.compactMap { Int($0) }
		let total = freqs.reduce(0, +)
		return String(total)
	}
}
