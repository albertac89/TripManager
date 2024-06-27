//
//  MapListVView.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI

struct MapListVView: View {
    var body: some View {
        VStack {
            MapListView(viewModel: MapListViewModel(tripsDataManager: TripsDataManager(api: Api(client: URLSession.shared))))
        }
    }
}

#Preview {
    MapListVView()
}
