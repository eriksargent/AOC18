//
//  Puzzle3_1.swift
//  AOC18
//
//  Created by Erik Sargent on 12/3/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle3_1: Puzzle {
	struct Point: Hashable {
		let x: Int
		let y: Int
		
		static func points(from rect: NSRect) -> Set<Point>{
			let xRange = Int(rect.minX)..<Int(rect.maxX)
			let yRange = Int(rect.minY)..<Int(rect.maxY)
			return Set(xRange.flatMap({ x -> [Point] in yRange.map({ y -> Point in Point(x: x, y: y) }) }))
		}
	}
	
	struct Claim {
		let id: Int
		let rect: NSRect
		
		init?(from array: [String]) {
			guard array.count == 6 else { return nil }
			let values = array[1..<6].map({ Int($0) }).unwrapped()
			guard values.count == 5 else { return nil }
			
			id = values[0]
			rect = NSRect(x: values[1], y: values[2], width: values[3], height: values[4])
		}
	}
		
	static let day = 3
	static let puzzle = 1
	
	static func solve(input: String) -> String {
		let pattern = Regex(pattern: "#(\\d+) @ (\\d+),(\\d+): (\\d+)x(\\d+)")
		let claimStrings = input.components(separatedBy: .newlines)
		let claimMatches = claimStrings.compactMap({ pattern.match($0)?.matches.unwrapped() }).filter({ $0.count == 6 })
		let claims = claimMatches.map({ Claim(from: $0) }).unwrapped()

		let numClaims = claims.count

		let intersectionsLock = NSLock()
		var intersections: [CGRect] = []

		DispatchQueue.concurrentPerform(iterations: claims.count) { index in
			let claim = claims[index]
			for claim2 in claims[index+1..<numClaims] {
				let intersection = claim.rect.intersection(claim2.rect)
				if intersection.size != .zero {
					intersectionsLock.lock()
					intersections.append(intersection)
					intersectionsLock.unlock()
				}
			}
		}
		
		var positions = Set<Point>()
		for int in intersections {
			positions.formUnion(Point.points(from: int))
		}

		return String(positions.count)
	}
}
