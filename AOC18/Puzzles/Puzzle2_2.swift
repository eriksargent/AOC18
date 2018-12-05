//
//  Puzzle2_2.swift
//  AOC18
//
//  Created by Erik Sargent on 12/2/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle2_2: Puzzle {
	static let day = 2
	static let puzzle = 2
	
	static func solve(input: String) -> String {
		let ids = input.components(separatedBy: .newlines)
		
		for first in ids {
			for second in ids {
				if first.diffByOne(from: second) {
					return first.inCommon(with: second)
				}
			}
		}
		
		return ""
	}
}


fileprivate extension String {
	func diffByOne(from other: String) -> Bool {
		guard self.count == other.count else {
			return false
		}
		
		var indexMe = startIndex
		var indexOther = other.startIndex
		
		var foundDiff = false
		
		while (indexMe != endIndex && indexOther != other.endIndex) {
			if self[indexMe] != other[indexOther] {
				guard !foundDiff else {
					return false
				}
				
				foundDiff = true
			}
			
			indexMe = index(after: indexMe)
			indexOther = index(after: indexOther)
		}
		
		return foundDiff
	}
	
	func inCommon(with other: String) -> String {
		var indexMe = startIndex
		var indexOther = other.startIndex
		
		var common = [Character]()
		
		while (indexMe != endIndex && indexOther != other.endIndex) {
			if self[indexMe] == other[indexOther] {
				common.append(self[indexMe])
			}
			
			indexMe = index(after: indexMe)
			indexOther = index(after: indexOther)
		}
		
		return String(common)
	}
}
