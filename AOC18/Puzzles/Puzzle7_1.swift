//
//  Puzzle7_1.swift
//  AOC18
//
//  Created by Erik Sargent on 12/6/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle7_1: Puzzle {
	static let day = 7
	static let puzzle = 1
	
	class Graph {
		var nodes = [Node]()
		
		var nextIndependent: Node? {
			return nodes.first(where: { $0.dependencies.isEmpty && !$0.done })
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
	}
	
	class Node {
		let id: String
		var dependencies = [Node]()
		var done = false
		
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
		
		var order = ""
		
		while let next = graph.nextIndependent {
			graph.finishWork(for: next)
			order.append(next.id)
		}
		
		return order
	}
}
