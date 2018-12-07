//
//  ViewController.swift
//  AOC18
//
//  Created by Erik Sargent on 11/26/18.
//  Copyright © 2018 ErikSargent. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	// MARK: - Properties
	@IBOutlet fileprivate weak var table: NSTableView!
	@IBOutlet fileprivate weak var puzzleTitleField: NSTextField!
	@IBOutlet fileprivate weak var inputField: NSTextField!
	@IBOutlet fileprivate weak var processButton: NSButton!
	@IBOutlet fileprivate weak var resultField: NSTextField!
	@IBOutlet fileprivate weak var timeField: NSTextField!
	
	fileprivate lazy var backgroundQueue = DispatchQueue(label: "BackgroundProcessing")
	
	fileprivate var puzzles: [Puzzle.Type] = [Puzzle1_1.self, Puzzle1_2.self, Puzzle2_1.self, Puzzle2_2.self, Puzzle3_1.self, Puzzle3_2.self, Puzzle4_1.self, Puzzle4_2.self, Puzzle5_1.self, Puzzle5_2.self, Puzzle6_1.self, Puzzle6_2.self]
	var activePuzzle: Puzzle.Type? {
		didSet {
			if let type = activePuzzle {
				puzzleTitleField.stringValue = type.name
			}
			else {
				puzzleTitleField.stringValue = ""
			}
		}
	}
	
	
	// MARK: - View Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		table.dataSource = self
		table.delegate = self
		
		if let first = puzzles.first {
			activePuzzle = first
		}
	}
	
	
	// MARK: - Actions
	@IBAction func processPuzzle(_ sender: NSButton) {
		resultField.stringValue = ""
		timeField.stringValue = ""
		
		guard let puzzle = activePuzzle else {
			return
		}
		
		let input = inputField.stringValue
		
		backgroundQueue.async {
			let start = Date()
			let result = puzzle.solve(input: input)
			let end = Date()
			let time = end.timeIntervalSince(start)
			
			DispatchQueue.main.async {
				let formatter = MeasurementFormatter()
				let runningTime = formatter.string(from: Measurement<UnitDuration>(value: time, unit: .seconds))
				
				self.resultField.stringValue = result
				self.timeField.stringValue = runningTime
			}
		}
		
	}
}


extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
	func numberOfRows(in tableView: NSTableView) -> Int {
		return puzzles.count
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		if let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PuzzleNameCell"), owner: nil) as? NSTableCellView {
			view.textField?.stringValue  = puzzles[row].name
			return view
		}
		
		return nil
	}
	
	func tableViewSelectionDidChange(_ notification: Notification) {
		inputField.stringValue = ""
		resultField.stringValue = ""
		timeField.stringValue = ""
		
		let selected = table.selectedRow
		activePuzzle = puzzles[selected]
	}
}

