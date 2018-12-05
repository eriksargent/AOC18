//
//  Puzzle2_1.swift
//  AOC18
//
//  Created by Erik Sargent on 12/2/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation



enum Puzzle2_1: Puzzle {
	static let day = 2
	static let puzzle = 1
	
	static func solve(input: String) -> String {
		let ids = input.components(separatedBy: .newlines)
		let counts = ids.map({ id -> [(Character, Int)] in
			let letters = Set(id)
			return letters.map({ ($0, id.count(of: $0)) })
		})
		
		print(counts)
		
		let twos = counts.map({ (count: [(Character, Int)]) -> (Int) in
			return count.contains(where: { $0.1 == 2 }) ? 1 : 0
		}).reduce(0, +)
		
		let threes = counts.map({ (count: [(Character, Int)]) -> (Int) in
			return count.contains(where: { $0.1 == 3 }) ? 1 : 0
		}).reduce(0, +)
		
		print("Twos: \(twos)")
		print("Threes: \(threes)")
		
		let checksum = twos * threes
		
		return String(checksum)
	}
}


fileprivate extension String {
	func count(of char: Character) -> Int {
		var count = 0
		var index = startIndex
		
		while (index != endIndex) {
			if self[index] == char {
				count += 1
			}
			index = self.index(after: index)
		}
		
		return count
	}
}
