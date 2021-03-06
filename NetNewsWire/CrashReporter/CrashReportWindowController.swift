//
//  CrashReportWindowController.swift
//  NetNewsWire
//
//  Created by Brent Simmons on 12/28/18.
//  Copyright © 2018 Ranchero Software. All rights reserved.
//

import Cocoa

final class CrashReportWindowController: NSWindowController {

	@IBOutlet var textView: NSTextView! {
		didSet {
			textView.font = NSFont.userFixedPitchFont(ofSize: 0.0)
			textView.textContainerInset = NSSize(width: 5.0, height: 5.0)
			textView.string = crashLogText
		}
	}

	@IBOutlet var sendCrashLogButton: NSButton!
	@IBOutlet var dontSendButton: NSButton!

	var testing = false // If true, crashLog won’t actually be sent.

	private var crashLogText: String!

	private var didSendCrashLog = false {
		didSet {
			sendCrashLogButton.isEnabled = !didSendCrashLog
			dontSendButton.isEnabled = !didSendCrashLog
		}
	}

	convenience init(crashLogText: String) {
		self.init(windowNibName: "CrashReporterWindow")
		self.crashLogText = crashLogText
	}

	override func windowDidLoad() {
		super.windowDidLoad()
		window!.center()
	}

	// MARK: - Actions

	@IBAction func sendCrashReport(_ sender: Any?) {
		guard !didSendCrashLog else {
			return
		}
		didSendCrashLog = true
		if !testing {
			CrashReporter.sendCrashLogText(crashLogText)
		}
//		showThanksSheet()
		close()
	}

	@IBAction func dontSendCrashReport(_ sender: Any?) {
		close()
	}
}

//private extension CrashReportWindowController {
//
//	func showThanksSheet() {
//		guard let window = window else {
//			return
//		}
//
//		let alert = NSAlert()
//		alert.alertStyle = .informational
//		alert.messageText = NSLocalizedString("Crash Report Sent", comment: "Crash Report Window")
//		alert.informativeText = NSLocalizedString("Thank you! You rock! This is a big help to us.", comment: "Crash Report Window")
//		alert.beginSheetModal(for: window)
//	}
//}
