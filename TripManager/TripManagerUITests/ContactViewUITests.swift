//
//  ContactViewUITests.swift
//  TripManagerUITests
//
//  Created by Albert Aige Cortasa on 1/7/24.
//

import XCTest
import Foundation

final class ContactViewUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func test_tap_concact() {
        let contactButton = app.buttons["Contact"]
        contactButton.tap()
        XCTAssert(!contactButton.exists)
    }

    func test_texts() {
        let contactButton = app.buttons["Contact"]
        contactButton.tap()

        let title = app.staticTexts["Contact form"]
        let backButton = app.buttons["TripManager"]
        let nameField = app.textFields["Name*"]
        let surnameField = app.textFields["Surname*"]
        let emailField = app.textFields["Email*"]
        let phoneField = app.textFields["Phone"]
        let dateLabel = app.staticTexts["Date*"]
        let dateButton = app.buttons["Date and Time Picker"]
        let descriptionLabel = app.staticTexts["Description*"]
        let submitButton = app.buttons["Submit"]

        XCTAssert(title.exists)
        XCTAssert(backButton.exists)
        XCTAssert(nameField.exists)
        XCTAssert(surnameField.exists)
        XCTAssert(emailField.exists)
        XCTAssert(phoneField.exists)
        XCTAssert(dateLabel.exists)
        XCTAssert(dateButton.exists)
        XCTAssert(descriptionLabel.exists)
        XCTAssert(submitButton.exists)
    }

    func test_button_back() {
        let contactButton = app.buttons["Contact"]
        contactButton.tap()

        let backButton = app.buttons["TripManager"]

        XCTAssert(backButton.exists)
        XCTAssert(!contactButton.exists)

        backButton.tap()

        XCTAssert(!backButton.exists)
        XCTAssert(contactButton.exists)
    }

    func test_button_submit_error() {
        let contactButton = app.buttons["Contact"]
        contactButton.tap()

        let submitButton = app.buttons["Submit"]
        submitButton.tap()

        let errorText = app.staticTexts["Missing required fields"]
        XCTAssert(errorText.exists)
    }

    func test_button_submit_success() {
        let contactButton = app.buttons["Contact"]
        contactButton.tap()

        let fieldName = app.textFields["Name*"]
        fieldName.tap()
        fieldName.typeText("name test")

        let fieldSurname = app.textFields["Surname*"]
        fieldSurname.tap()
        fieldSurname.typeText("surname test")

        let fieldEmail = app.textFields["Email*"]
        fieldEmail.tap()
        fieldEmail.typeText("email test")

        let fieldPhone = app.textFields["Phone"]
        fieldPhone.tap()
        fieldPhone.typeText("123456789")

        let datePicker = app.datePickers.firstMatch
        datePicker.tap()
        let datePickerElements = datePicker.buttons.allElementsBoundByIndex.count
        if let lastDayOfMonth = datePicker.buttons.allElementsBoundByIndex.last, lastDayOfMonth.isSelected {
            lastDayOfMonth.tap()
        } else if !datePicker.buttons.allElementsBoundByIndex[datePickerElements - 1].isSelected {
            datePicker.buttons.allElementsBoundByIndex[datePickerElements - 1].tap()
        }
        fieldPhone.tap()

        let description = app.textViews.firstMatch
        description.tap()
        description.typeText("description test")

        let descritionCounterText = app.staticTexts["16 / 200"]
        XCTAssert(descritionCounterText.exists)

        let submitButton = app.buttons["Submit"]
        submitButton.tap()

        let errorText = app.staticTexts["Form sent succesfully"]
        XCTAssert(errorText.exists)
    }
}
