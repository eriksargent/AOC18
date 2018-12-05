//
//  Puzzle5_1.swift
//  AOC18
//
//  Created by Erik Sargent on 12/5/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle5_1: Puzzle {
	static let day = 5
	static let puzzle = 1
	
	static func isOppositeCase(_ lhs: Character, _ rhs: Character) -> Bool {
		guard lhs != rhs else { return false }
		
		let ls = String(lhs)
		let rs = String(rhs)
		
		if ls.uppercased() == rs {
			return true
		}
		
		if ls == rs.uppercased() {
			return true
		}
		
		return false
	}
	
	static func solve(input: String) -> String {
		var units = input
		var changes = false
		
		repeat {
			changes = false
			var index = units.startIndex
			var next = units.index(after: index)
			
			while (next < units.endIndex) {
				if isOppositeCase(units[index], units[next]) {
					units.removeSubrange(index...next)
					changes = true
				}
				else {
					index = next
					next = units.index(after: index)
				}
			}
		} while (changes && !units.isEmpty)
		
		return String(units.count)
	}
}
