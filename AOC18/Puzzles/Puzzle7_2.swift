//
//  Puzzle7_2.swift
//  AOC18
//
//  Created by Erik Sargent on 12/6/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle7_2: Puzzle {
	static let day = 7
	static let puzzle = 2
	
	class Worker {
		var current: Node?
		var timeRemaining = 0
		
		func addWork(_ node: Node) {
			current = node
			timeRemaining = 60 + (Int(node.id.unicodeScalars.first!.value) - Int("A".unicodeScalars.first!.value))
			node.assigned = true
		}
	}
	
	class Graph {
		var nodes = [Node]()
		
		var nextIndependent: Node? {
			return nodes.first(where: { $0.dependencies.isEmpty && !$0.done && !$0.assigned })
		}
		
		func finishWork(for node: Node) {
			node.done = true
			for n in nodes {
				n.dependencies.removeAll { $0.id == node.id }
			}
		}
		
		subscript(id: String) -> Node {
			if let node = nodes.first(where: { $0.id == id }) {
				return node
			}
			else {
				let node = Node(id: id)
				nodes.append(node)
				return node
			}
		}
		
		var finished: Bool {
			return nodes.map({ $0.done }).reduce(true, { $0 && $1 })
		}
	}
	
	class Node {
		let id: String
		var dependencies = [Node]()
		var done = false
		var assigned = false
		
		init(id: String) {
			self.id = id
		}
	}
	
	static func solve(input: String) -> String {
		let pattern = Regex(pattern: "Step ([A-Z]) must be finished before step ([A-Z]) can begin\\.")
		let matches = pattern.matches(in: input)
		let requirements = matches.filter({ $0.matches.count == 3 }).map({ $0.matches[1...2].unwrapped() }).filter({ $0.count == 2 }).map({ ($0[0], $0[1]) })
		let graph = Graph()
		
		for req in requirements {
			graph[req.1].dependencies.append(graph[req.0])
		}
		graph.nodes.sort(by: { $0.id < $1.id })
		print(graph.nodes.map({ $0.id }))
		
		let workers = [Worker(), Worker(), Worker(), Worker(), Worker()]
//		let workers = [Worker(), Worker()]
		var totalTime = -1
		
		while !graph.finished {
			for worker in workers {
				if let node = worker.current {
					if worker.timeRemaining <= 0 {
						graph.finishWork(for: node)
						
						if let next = graph.nextIndependent {
							worker.addWork(next)
						}
						else {
							worker.current = nil
						}
					}
					else {
						worker.timeRemaining -= 1
					}
				}
				else if let next = graph.nextIndependent {
					worker.addWork(next)
				}
			}
			totalTime += 1
		}
		
		return String(totalTime)
	}
}
