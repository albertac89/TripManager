//
//  StopsDataManager.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

import Foundation

protocol StopsDataManagerProtocol {
    func getStops() async throws -> Stop?
}

final class StopsDataManager {
    var api: ApiProtocol

    init(api: ApiProtocol) {
        self.api = api
    }
}

extension StopsDataManager: StopsDataManagerProtocol {
    func getStops() async throws -> Stop? {
        try await api.getData(from: "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/stops.json")
    }
}
