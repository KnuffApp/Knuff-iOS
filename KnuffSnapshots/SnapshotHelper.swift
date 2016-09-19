//
//  SnapshotHelper.swift
//  Example
//
//  Created by Felix Krause on 10/8/15.
//  Copyright © 2015 Felix Krause. All rights reserved.
//

import Foundation
import XCTest

var deviceLanguage = ""

@available(*, deprecated, message: "use setupSnapshot: instead")
func setLanguage(_ app: XCUIApplication) {
    setupSnapshot(app)
}

func setupSnapshot(_ app: XCUIApplication) {
    Snapshot.setupSnapshot(app)
}

func snapshot(_ name: String, waitForLoadingIndicator: Bool = false) {
    Snapshot.snapshot(name, waitForLoadingIndicator: waitForLoadingIndicator)
}

class Snapshot: NSObject {

    class func setupSnapshot(_ app: XCUIApplication) {
        setLanguage(app)
        setLaunchArguments(app)
    }

    class func setLanguage(_ app: XCUIApplication) {
        let path = "/tmp/language.txt"

        do {
            let locale = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) as String
            deviceLanguage = locale.substring(to: locale.characters.index(locale.startIndex, offsetBy: 2, limitedBy:locale.endIndex)!)
            app.launchArguments += ["-AppleLanguages", "(\(deviceLanguage))", "-AppleLocale", "\"\(locale)\"", "-ui_testing"]
        } catch {
            print("Couldn't detect/set language...")
        }
    }

    class func setLaunchArguments(_ app: XCUIApplication) {
        let path = "/tmp/snapshot-launch_arguments.txt"

        app.launchArguments += ["-FASTLANE_SNAPSHOT", "YES"]

        do {
            let launchArguments = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) as String
            let regex = try NSRegularExpression(pattern: "(\\\".+?\\\"|\\S+)", options: [])
            let matches = regex.matches(in: launchArguments, options: [], range: NSRange(location:0, length:launchArguments.characters.count))
            let results = matches.map { result -> String in
                (launchArguments as NSString).substring(with: result.range)
            }
            app.launchArguments += results
        } catch {
            print("Couldn't detect/set launch_arguments...")
        }
    }

    class func snapshot(_ name: String, waitForLoadingIndicator: Bool = false) {
        if waitForLoadingIndicator {
            waitForLoadingIndicatorToDisappear()
        }

        print("snapshot: \(name)") // more information about this, check out https://github.com/krausefx/snapshot

        sleep(1) // Waiting for the animation to be finished (kind of)
        XCUIDevice.shared().orientation = .unknown
    }

    class func waitForLoadingIndicatorToDisappear() {
        let query = XCUIApplication().statusBars.children(matching: .other).element(boundBy: 1).children(matching: .other)
        
        while query.count > 4 {
            sleep(1)
            print("Number of Elements in Status Bar: \(query.count)... waiting for status bar to disappear")
        }
    }
}

// Please don't remove the lines below
// They are used to detect outdated configuration files
// SnapshotHelperVersion [[1.0]]
