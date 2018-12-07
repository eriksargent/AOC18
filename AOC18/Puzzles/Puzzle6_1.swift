//
//  Puzzle6_1.swift
//  AOC18
//
//  Created by Erik Sargent on 12/6/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle6_1: Puzzle {
	static let day = 6
	static let puzzle = 1
	
	class Point {
		var x: Int
		var y: Int
		var id: Int
		var infinite = false
		
		init(string: String, id: Int) {
			self.id = id
			
			let comps = string.components(separatedBy: ", ").compactMap({ Int($0 ) })
			guard comps.count == 2 else {
				x = 0
				y = 0
				return
			}
			
			x = comps[0]
			y = comps[1]
		}
		
		func manhattenDistance(toX x: Int, y: Int) -> Int {
			return abs(x - self.x) + abs(y - self.y)
		}
	}
	
	class Grid: CustomStringConvertible {
		var grid: [[Int]]
		var sizeX: Int
		var sizeY: Int
		var points: [Point]
		
		init(points: [Point]) {
			self.points = points
			sizeX = (points.map({ $0.x }).max() ?? 0) + 1
			sizeY = (points.map({ $0.y }).max() ?? 0) + 1
			grid = [[Int]](repeating: [Int](repeating: -1, count: sizeY), count: sizeX)
			
			for point in points {
				grid[point.x][point.y] = point.id
			}
			
			for x in 0..<sizeX {
				for y in 0..<sizeY {
					if grid[x][y] < 0 {
						grid[x][y] = points.closest(toX: x, y: y)
					}
				}
			}
		}
		
		func removeInfinite() {
			for y in [0, sizeY - 1] {
				for x in 0..<sizeX where grid[x][y] >= 0 {
					points[grid[x][y]].infinite = true
				}
			}
			for y in 0..<sizeY {
				for x in [0, sizeX - 1] where grid[x][y] >= 0 {
					points[grid[x][y]].infinite = true
				}
			}
		}
		
		func area(for point: Int) -> Int {
			guard !points[point].infinite else { return -1 }
			
			return grid.flatMap({ $0.filter({ p in p == point }) }).count
		}
		
		func bestArea() -> Int {
			return points.map({ area(for: $0.id) }).max() ?? 0
		}
		
		var description: String {
			var desc = ""
			for y in 0..<sizeY {
				for x in 0..<sizeX {
					if grid[x][y] < 0 {
						desc.append(". ")
					}
					else {
						desc.append("\(grid[x][y]) ")
					}
				}
				desc.append("\n")
			}
			
			return desc
		}
	}
	
	static func solve(input: String) -> String {
		let coordStrings = input.components(separatedBy: .newlines)
		let points = coordStrings.enumerated().map({ Point(string: $1, id: $0) })
		let grid = Grid(points: points)
		grid.removeInfinite()
		
		return String(grid.bestArea())
	}
}


extension Array where Element == Puzzle6_1.Point {
	func closest(toX x: Int, y: Int) -> Int {
		var best = Int.max
		var bestPoint = -1
		for point in self {
			let md = point.manhattenDistance(toX: x, y: y)
			if md < best {
				best = md
				bestPoint = point.id
			}
			else if md == best {
				bestPoint = -1
			}
		}
		
		return bestPoint
	}
}
