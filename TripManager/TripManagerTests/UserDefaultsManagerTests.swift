//
//  UserDefaultsManagerTests.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

import XCTest
@testable import TripManager

final class UserDefaultsManagerTests: XCTestCase {
    private var sut: UserDefaultsManager?
    private let userDefautsKey = "test"

    override func setUpWithError() throws {
        sut = UserDefaultsManager()
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.set(nil, forKey: userDefautsKey)
    }

    func test_set_get() {
        let value = ["test","123"]

        sut?.set(value: value, for: "test")

        let result = sut?.get([String].self, valueFor: userDefautsKey)

        XCTAssertEqual(result, value)
    }

    func test_get() {
        let result = sut?.get([String].self, valueFor: userDefautsKey)

        XCTAssertEqual(result, nil)
    }
}
