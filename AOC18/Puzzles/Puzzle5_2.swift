//
//  Puzzle5_2.swift
//  AOC18
//
//  Created by Erik Sargent on 12/5/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle5_2: Puzzle {
	static let day = 5
	static let puzzle = 2
	
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
	
	static func uppercase(of char: Character) -> Character {
		let up = String(char).uppercased()
		return up[up.startIndex]
	}
	
	static func solve(input: String) -> String {
		let possibleUnits = Set(input.lowercased())
		
		var bestUnits = input
		for possibility in possibleUnits {
			let upperPossibility = uppercase(of: possibility)
			var units = input
			units.removeAll(where: { $0 == possibility || $0 == upperPossibility })
			
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
			
			if units.count < bestUnits.count {
				bestUnits = units
			}
		}
		
		return String(bestUnits.count)
	}
}
