//
//  StopsMock.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

@testable import TripManager

struct StopsMock {
    static var data: Stop {
        Stop(price: 1.4, address: "testAddress", tripId: 0, paid: false, stopTime: "2018-12-18T08:00:00.000Z", point: Stop.Point(latitude: 132132.0, longitude: 123132.0), userName: "testUsername")
    }
}
