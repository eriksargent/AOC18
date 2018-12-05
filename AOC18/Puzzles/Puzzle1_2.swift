//
//  Puzzle1_2.swift
//  AOC18
//
//  Created by Erik Sargent on 11/26/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle1_2: Puzzle {
	static let day = 1
	static let puzzle = 2
	
	static func solve(input: String) -> String {
		let comps = input.components(separatedBy: CharacterSet(charactersIn: ",").union(.whitespacesAndNewlines))
		let freqs = comps.compactMap { Int($0) }
		
		var total = 0
		var seen = Set<Int>(arrayLiteral: total)
		var numSeen = seen.count
		
		while true {
			for freq in freqs {
				total += freq
				seen.insert(total)
				
				let newCount = seen.count
				
				// Count didn't change, this is a duplicate value
				if newCount == numSeen {
					return String(total)
				}
				numSeen = newCount
			}
		}
	}
}

