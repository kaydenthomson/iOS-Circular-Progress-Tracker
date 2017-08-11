//
//  Circular_Progress_TrackerTests.swift
//  Circular Progress TrackerTests
//
//  Created by Kayden Thomson on 8/8/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import XCTest
@testable import Circular_Progress_Tracker

class Circular_Progress_TrackerTests: XCTestCase {
    
    let dateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()

        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
    }
    
    func testProgressInitializationSucceeds() {
        let wakeTime: Date = dateFormatter.date(from: "12:00 AM")!
        let sleepTime: Date = dateFormatter.date(from: "11:59 PM")!
        
        let progress = Progress.init(wakeTime: wakeTime, sleepTime: sleepTime, countingDown: true, colorTheme: .Blue)
        XCTAssertNotNil(progress)
    }
    
}
