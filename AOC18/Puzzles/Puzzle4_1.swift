//
//  Puzzle4_1.swift
//  AOC18
//
//  Created by Erik Sargent on 12/4/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Foundation


enum Puzzle4_1: Puzzle {
	static let day = 4
	static let puzzle = 1
	
	enum Event {
		case began, sleep, woke
	}
	
	class Guard: Equatable, CustomStringConvertible {
		let id: Int
		var events: [(event: Event, date: Date)] = []
		
		init(id: Int) {
			self.id = id
		}
		
		var minutesAsleep: Int {
			var total: TimeInterval = 0
			var asleepTime: Date?
			for event in events {
				switch event.event {
				case .sleep:
					asleepTime = event.date
				case .woke:
					if let start = asleepTime {
						let interval = event.date.timeIntervalSince(start)
						total += interval
					}
					
				default:
					break
				}
			}
			
			return Int(Measurement<UnitDuration>(value: total, unit: .seconds).converted(to: .minutes).value)
		}
		
		func minute(from date: Date) -> Int {
			return Calendar.current.component(.minute, from: date)
		}
		
		var maxMinute: Int {
			var sleepingMinutes = [Int]()
			var asleepTime: Date?
			
			for event in events {
				switch event.event {
				case .sleep:
					asleepTime = event.date
				case .woke:
					if let start = asleepTime {
						var interval = Calendar.current.dateInterval(of: .minute, for: start)!
						while interval.end < event.date {
							sleepingMinutes.append(minute(from: interval.start))
							interval = Calendar.current.dateInterval(of: .minute, for: interval.end.addingTimeInterval(1))!
						}
						sleepingMinutes.append(minute(from: interval.start))
					}
					
				default:
					break
				}
			}
			
			let options = Set(sleepingMinutes)
			let counts = options.map({ minute -> (Int, Int) in (minute, sleepingMinutes.filter({ $0 == minute }).count) })
			let max = counts.max(by: { $0.1 < $1.1 })!
			
			return max.0
		}
		
		var identifier: Int {
			return id * maxMinute
		}
		
		static func ==(lhs: Guard, rhs: Guard) -> Bool {
			return lhs.id == rhs.id
		}
		
		var description: String {
			var desc = ""
			for event in events {
				desc.append("  " + String(describing: event.date) + ": " + String(describing: event.event) + "\n")
			}
			
			desc.append("total sleeping: \(minutesAsleep)\n")
			desc.append("Minute most likely to be sleeping: \(maxMinute)\n")
			desc.append("Identifier: \(identifier)")
			return desc
		}
	}
	
	class Guards: CustomStringConvertible {
		var guards = [Guard]()
		
		subscript(id: Int) -> Guard {
			if let first = guards.first(where: { $0.id == id }) {
				return first
			}
			
			let g = Guard(id: id)
			guards.append(g)
			return g
		}
		
		var bestChoice: Int {
			for g in guards {
				g.events.sort(by: { $0.date < $1.date })
			}
			let best = guards.max(by: { $0.minutesAsleep < $1.minutesAsleep })!
			print(best.id)
			print(best)
			return best.identifier
		}
		
		var description: String {
			var desc = ""
			for g in guards {
				desc.append("\(g.id):\n" + g.description + "\n")
			}
			return desc
		}
	}
	
	static func solve(input: String) -> String {
		let pattern = Regex(pattern: "\\[(.*)\\] (.*)")
		let patternBegin = Regex(pattern: "Guard \\#(\\d+) begins shift")
		let patternAsleep = "falls asleep"
		let patternWake = "wakes up"
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "y-M-d H:m"
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		let events = pattern.matches(in: input.components(separatedBy: .newlines).sorted().joined(separator: "\n"))
		
		var currentGuard: Guard?
		let guards = Guards()
		
		for event in events where event.matches.count == 3 {
			if let dateString = event.matches[1], let date = dateFormatter.date(from: dateString), let eventString = event.matches[2] {
				
				if let match = patternBegin.match(eventString), let idString = match.matches[1], let id = Int(idString) {
					currentGuard = guards[id]
					currentGuard?.events.append((event: .began, date: date))
				}
				else if eventString == patternAsleep {
					currentGuard?.events.append((event: .sleep, date: date))
				}
				else if eventString == patternWake {
					currentGuard?.events.append((event: .woke, date: date))
				}
			}
		}
		
		let answer = guards.bestChoice
		print(guards)
		
		return String(answer)
	}
}
