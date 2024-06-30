//
//  ContactViewModelTests.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

import XCTest
@testable import TripManager

@MainActor
final class ContactViewModelTests: XCTestCase {
    private let notificationsCenter = NotificationsCenterMock()
    private let userDefaultsManager = UserDefaultsManagerMock()
    private var sut: ContactViewModel?

    override func setUpWithError() throws {
        sut = ContactViewModel(notificationsCenter: notificationsCenter, userDefaultsManager: userDefaultsManager)
    }

    func test_submit_empty_form() async {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        // Initial values
        XCTAssertTrue(sut.isNameValid)
        XCTAssertTrue(sut.isSurnameValid)
        XCTAssertTrue(sut.isEmailValid)
        XCTAssertTrue(sut.isDateValid)
        XCTAssertFalse(sut.isDateCanged)
        XCTAssertTrue(sut.isDescriptionValid)
        XCTAssertFalse(sut.showRequiredFields)
        XCTAssertFalse(sut.showFormSent)
        XCTAssertEqual(notificationsCenter.notificationPermisionsSpy, 0)
        XCTAssertEqual(notificationsCenter.setBadgeCountSpy, 0)
        XCTAssertEqual(userDefaultsManager.setSpy, 0)
        XCTAssertEqual(userDefaultsManager.getSpy, 0)
        XCTAssertEqual(notificationsCenter.setBadgeCountValue, 0)

        // Submit form
        await sut.submit()

        // Check
        XCTAssertFalse(sut.isNameValid)
        XCTAssertFalse(sut.isSurnameValid)
        XCTAssertFalse(sut.isEmailValid)
        XCTAssertFalse(sut.isDateValid)
        XCTAssertFalse(sut.isDateCanged)
        XCTAssertFalse(sut.isDescriptionValid)
        XCTAssertTrue(sut.showRequiredFields)
        XCTAssertFalse(sut.showFormSent)
        XCTAssertEqual(notificationsCenter.notificationPermisionsSpy, 0)
        XCTAssertEqual(notificationsCenter.setBadgeCountSpy, 0)
        XCTAssertEqual(userDefaultsManager.setSpy, 0)
        XCTAssertEqual(userDefaultsManager.getSpy, 0)
        XCTAssertEqual(notificationsCenter.setBadgeCountValue, 0)
    }

    func test_submit_filled_form_and_user_defauts_case_empty() async {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        // Initial values
        XCTAssertTrue(sut.isNameValid)
        XCTAssertTrue(sut.isSurnameValid)
        XCTAssertTrue(sut.isEmailValid)
        XCTAssertTrue(sut.isDateValid)
        XCTAssertFalse(sut.isDateCanged)
        XCTAssertTrue(sut.isDescriptionValid)
        XCTAssertFalse(sut.showRequiredFields)
        XCTAssertFalse(sut.showFormSent)
        XCTAssertEqual(notificationsCenter.notificationPermisionsSpy, 0)
        XCTAssertEqual(notificationsCenter.setBadgeCountSpy, 0)
        XCTAssertEqual(userDefaultsManager.setSpy, 0)
        XCTAssertEqual(userDefaultsManager.getSpy, 0)
        XCTAssertEqual(notificationsCenter.setBadgeCountValue, 0)

        // Fill form
        sut.form.name = "test"
        sut.form.surname = "test"
        sut.form.email = "test"
        sut.form.phone = "465465"
        sut.form.date = Date.now
        sut.isDateCanged = true
        sut.form.description = "test"

        // Submit form
        await sut.submit()

        // Check
        XCTAssertTrue(sut.isNameValid)
        XCTAssertTrue(sut.isSurnameValid)
        XCTAssertTrue(sut.isEmailValid)
        XCTAssertTrue(sut.isDateValid)
        XCTAssertTrue(sut.isDateCanged)
        XCTAssertTrue(sut.isDescriptionValid)
        XCTAssertFalse(sut.showRequiredFields)
        XCTAssertTrue(sut.showFormSent)
        XCTAssertEqual(notificationsCenter.notificationPermisionsSpy, 0)
        XCTAssertEqual(notificationsCenter.setBadgeCountSpy, 1)
        XCTAssertEqual(userDefaultsManager.setSpy, 1)
        XCTAssertEqual(userDefaultsManager.getSpy, 1)
        XCTAssertEqual(notificationsCenter.setBadgeCountValue, 1)
    }

    func test_description_limit() {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        // Initial values
        XCTAssertEqual(sut.form.description.count, 0)

        // Set description with less than 200 characters
        sut.form.description = "test"

        // Check
        XCTAssertEqual(sut.form.description.count, 4)

        // Set description with more than 200 characters
        sut.form.description = "test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test"

        // Check
        XCTAssertEqual(sut.form.description.count, 200)
    }

    func test_submit_user_defauts_case_full() async {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        userDefaultsManager.getRetrun = ContactMock.data

        // Initial values
        XCTAssertEqual(userDefaultsManager.setSpy, 0)
        XCTAssertEqual(userDefaultsManager.getSpy, 0)
        XCTAssertEqual(notificationsCenter.setBadgeCountSpy, 0)
        XCTAssertEqual(notificationsCenter.setBadgeCountValue, 0)

        // Fill form
        sut.form.name = "test"
        sut.form.surname = "test"
        sut.form.email = "test"
        sut.form.phone = "465465"
        sut.form.date = Date.now
        sut.isDateCanged = true
        sut.form.description = "test"

        // Submit form
        await sut.submit()

        // Check
        XCTAssertEqual(userDefaultsManager.setSpy, 1)
        XCTAssertEqual(userDefaultsManager.getSpy, 1)
        XCTAssertEqual(notificationsCenter.setBadgeCountSpy, 1)
        XCTAssertEqual(notificationsCenter.setBadgeCountValue, 4)
    }
}
