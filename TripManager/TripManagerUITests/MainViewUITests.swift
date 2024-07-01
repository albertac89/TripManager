//
//  MainViewUITests.swift
//  TripManagerUITests
//
//  Created by Albert Aige Cortasa on 1/7/24.
//

import XCTest

final class MainViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func test_texts() throws {
        let appTitle = app.staticTexts["TripManager"]
        let contactButton = app.buttons["Contact"]

        XCTAssert(appTitle.exists)
        XCTAssert(contactButton.exists)
    }
}
