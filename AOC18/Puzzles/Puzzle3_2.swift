//
//  Puzzle3_2.swift
//  AOC18
//
//  Created by Erik Sargent on 12/3/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle3_2: Puzzle {
	struct Claim: Equatable {
		let id: Int
		let rect: NSRect
//		var hasIntersection = false
		
		init?(from array: [String]) {
			guard array.count == 6 else { return nil }
			let values = array[1..<6].map({ Int($0) }).unwrapped()
			guard values.count == 5 else { return nil }
			
			id = values[0]
			rect = NSRect(x: values[1], y: values[2], width: values[3], height: values[4])
		}
		
		static func ==(lhs: Claim, rhs: Claim) -> Bool {
			return lhs.id == rhs.id
		}
	}
	
	static let day = 3
	static let puzzle = 2
	
	static func solve(input: String) -> String {
		let pattern = Regex(pattern: "#(\\d+) @ (\\d+),(\\d+): (\\d+)x(\\d+)")
		let claimStrings = input.components(separatedBy: .newlines)
		let claimMatches = claimStrings.compactMap({ pattern.match($0)?.matches.unwrapped() }).filter({ $0.count == 6 })
		let claims = claimMatches.map({ Claim(from: $0) }).unwrapped()
		
		let lone = claims.first(where: { claim in !claims.contains(where: { $0 != claim && claim.rect.intersects($0.rect) }) })
		return String(lone!.id)
	}
}
