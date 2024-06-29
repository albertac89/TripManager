//
//  StopsDataManagerMock.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

@testable import TripManager

final class StopsDataManagerMock: StopsDataManagerProtocol {
    var getStopsShouldShowError = false
    var getStopsSpy = 0
    func getStops() async throws -> TripManager.Stop? {
        getStopsSpy += 1
        if getStopsShouldShowError {
            throw MockAPIError.forcedTestError
        }
        return StopsMock.data
    }
}
