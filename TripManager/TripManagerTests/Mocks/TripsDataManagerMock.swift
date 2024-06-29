//
//  TripsDataManagerMock.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

@testable import TripManager

final class TripsDataManagerMock: TripsDataManagerProtocol {
    var getTripsShouldShowError = false
    var getTripsSpy = 0
    func getTrips() async throws -> [TripManager.Trip]? {
        getTripsSpy += 1
        if getTripsShouldShowError {
            throw MockAPIError.forcedTestError
        }
        return TripsMock.data
    }
}
