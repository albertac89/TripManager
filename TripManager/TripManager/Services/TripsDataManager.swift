//
//  TripsDataManager.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import Foundation

protocol TripsDataManagerProtocol {
    /**
     func getTrips() async throws -> [Trip]?
     - returns: An array of Trips of type [Trip]?
     */
    func getTrips() async throws -> [Trip]?
}

final class TripsDataManager {
    var api: ApiProtocol
    struct Constants {
        static let tripsPath = "/tech-test/trips.json"
    }

    init(api: ApiProtocol) {
        self.api = api
    }
}

extension TripsDataManager: TripsDataManagerProtocol {
    func getTrips() async throws -> [Trip]? {
        try await api.getData(from: Api.Constants.host + Constants.tripsPath)
    }
}
