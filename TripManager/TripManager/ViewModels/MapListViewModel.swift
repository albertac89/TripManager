//
//  MapListViewModel.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI
import Foundation
import MapKit

// TODO add function comments
@MainActor
final class MapListViewModel: ObservableObject {
    private let tripsDataManager: TripsDataManagerProtocol
    private let stopsDataManager: StopsDataManagerProtocol
    @Published var trips: [Trip] = []
    @Published var stop: Stop?
    @Published var errorDescription: String?
    @Published var showError = false
    enum Constants {
        static let pullToRefreshString = "Pull to refresh"
    }

    init(tripsDataManager: TripsDataManagerProtocol, stopsDataManager: StopsDataManagerProtocol) {
        self.tripsDataManager = tripsDataManager
        self.stopsDataManager = stopsDataManager
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

    @Sendable
    func loadStops()  async {
        showError = false
        do {
            stop = try await stopsDataManager.getStops()
        } catch {
            showError = true
            errorDescription = error.localizedDescription
        }
    }

    func cameraPosition(for polyline: MKPolyline) -> MKMapRect {
        var rect = polyline.boundingMapRect
        let wPadding = rect.size.width * 0.25
        let hPadding = rect.size.height * 0.25

        // Add padding to the region
        rect.size.width += wPadding
        rect.size.height += hPadding

        // Center the region on the line
        rect.origin.x -= wPadding / 2
        rect.origin.y -= hPadding / 2
        return rect
    }
}
