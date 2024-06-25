//
//  MapList.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI
import MapKit

struct MapList: View {
    @ObservedObject var viewModel: MapListViewModel

    var body: some View {
        Map(bounds: MapCameraBounds(centerCoordinateBounds: viewModel.initialLocation)) {

        }
        List(viewModel.trips) { trip in
            TripCell(trip: trip)
        }
        .listStyle(.plain)
        .task(viewModel.loadTrips)
        .refreshable(action: viewModel.loadTrips)
        .alert(viewModel.errorDescription ?? "", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) { }
            }
    }
}

#Preview {
    MapList(viewModel: MapListViewModel(tripsDataManager: TripsDataManager(api: Api(client: URLSession.shared))))
}
