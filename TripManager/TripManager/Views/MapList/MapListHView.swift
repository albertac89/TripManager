//
//  MapListHView.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI

struct MapListHView: View {
    var body: some View {
        HStack {
            MapListView(viewModel: MapListViewModel(tripsDataManager: TripsDataManager(api: Api(client: URLSession.shared))))
        }
    }
}

#Preview {
    MapListHView()
}
