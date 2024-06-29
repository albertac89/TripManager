//
//  ContactMock.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

@testable import TripManager
import Foundation

struct ContactMock {
    static var data: [Contact] {
        [Contact(name: "test", surname: "test", email: "test", phone: "123456", date: Date.now, description: "test"),
         Contact(name: "test", surname: "test", email: "test", phone: "123456", date: Date.now, description: "test"),
         Contact(name: "test", surname: "test", email: "test", phone: "123456", date: Date.now, description: "test")]
    }
}
