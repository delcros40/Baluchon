//
//  BaluchonScreenShotsUITests.swift
//  BaluchonScreenShotsUITests
//
//  Created by DELCROS Jean-baptiste on 03/04/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import XCTest

class BaluchonScreenShotsUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func testScreenShot() {
        snapshot("devise")
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Translation"].tap()
        snapshot("translation")
        tabBarsQuery.buttons["Weather"].tap()
        snapshot("weather")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
