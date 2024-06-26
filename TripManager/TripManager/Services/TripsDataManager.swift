//
//  TripsDataManager.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import Foundation

protocol TripsDataManagerProtocol {
    func getTrips() async throws -> [Trip]?
    func getStops() async throws -> Stop?
}

final class TripsDataManager {
    var api: ApiProtocol

    init(api: ApiProtocol) {
        self.api = api
    }
}

extension TripsDataManager: TripsDataManagerProtocol {
    func getTrips() async throws -> [Trip]? {
        try await api.getData(from: "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/trips.json")
    }

    func getStops() async throws -> Stop? {
        try await api.getData(from: "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/stops.json")
    }
}
