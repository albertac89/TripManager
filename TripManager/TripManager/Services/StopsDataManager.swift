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
    struct Constants {
        static let stops = "/tech-test/stops.json"
    }

    init(api: ApiProtocol) {
        self.api = api
    }
}

extension StopsDataManager: StopsDataManagerProtocol {
    func getStops() async throws -> Stop? {
        try await api.getData(from: Api.Constants.host+Constants.stops)
    }
}
