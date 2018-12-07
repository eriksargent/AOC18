//
//  Puzzle6_2.swift
//  AOC18
//
//  Created by Erik Sargent on 12/6/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle6_2: Puzzle {
	static let day = 6
	static let puzzle = 2
	
	static var distanceThreshold = 10000
	
	class Point {
		var x: Int
		var y: Int
		var id: Int
		
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
	
	class Grid {
		var grid: [[Int]]
		var sizeX: Int
		var sizeY: Int
		var points: [Point]
		
		init(points: [Point]) {
			self.points = points
			sizeX = (points.map({ $0.x }).max() ?? 0) + 1
			sizeY = (points.map({ $0.y }).max() ?? 0) + 1
			grid = [[Int]](repeating: [Int](repeating: -1, count: sizeY), count: sizeX)
			
			for y in 0..<sizeY {
				for x in 0..<sizeX {
					grid[x][y] = points.map({ $0.manhattenDistance(toX: x, y: y) }).reduce(0, +)
				}
			}
		}
		
		var regionSize: Int {
			return grid.flatMap({ horiz in horiz.filter({ $0 < Puzzle6_2.distanceThreshold }) }).count
		}
	}
	
	static func solve(input: String) -> String {
		let coordStrings = input.components(separatedBy: .newlines)
		let points = coordStrings.enumerated().map({ Point(string: $1, id: $0) })
		let grid = Grid(points: points)
		
		return String(grid.regionSize)
	}
}
