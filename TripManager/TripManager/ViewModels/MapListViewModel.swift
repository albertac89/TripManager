//
//  MapListViewModel.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import Foundation
import MapKit

@MainActor
final class MapListViewModel: ObservableObject {
    private let tripsDataManager: TripsDataManagerProtocol
    @Published var trips: [Trip] = []
    @Published var errorDescription: String?
    @Published var showError = false
    enum Constants {
        static let pullToRefreshString = "Pull to refresh"
    }
    //@Published var selectedTrip: Trip? //pass view model to select de trip an update the view: part 2

    let initialLocation = MKMapRect(
        origin: MKMapPoint(.barcelona),
        size: MKMapSize(width: 1, height: 1)
    )

    init(tripsDataManager: TripsDataManagerProtocol) {
        self.tripsDataManager = tripsDataManager
    }
}

extension MapListViewModel {
    @Sendable
    func loadTrips() async {
        showError = false
        do {
            trips = try await tripsDataManager.getTrips() ?? []
        } catch {
            showError = true
            errorDescription = error.localizedDescription + "\n\n" + Constants.pullToRefreshString
        }
    }
}
