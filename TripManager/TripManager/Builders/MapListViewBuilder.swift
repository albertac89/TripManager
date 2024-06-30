//
//  MapListViewBuilder.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 28/6/24.
//

import Foundation

struct MapListViewBuilder {
    /**
     static func build() -> MapListView
     Build the MapListView with all the dependencies
     - returns: A MapListView with all the dependencies injected
     */
    @MainActor
    static func build() -> MapListView {
        let api = Api(client: URLSession.shared)
        let tripsDataManager = TripsDataManager(api: api)
        let stopsDataManager = StopsDataManager(api: api)
        let viewModel = MapListViewModel(tripsDataManager: tripsDataManager, stopsDataManager: stopsDataManager)
        return MapListView(viewModel: viewModel)
    }
}
