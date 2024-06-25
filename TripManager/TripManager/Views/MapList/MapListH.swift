//
//  MapListH.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI

struct MapListH: View {
    var body: some View {
        HStack {
            MapList(viewModel: MapListViewModel(tripsDataManager: TripsDataManager(api: Api(client: URLSession.shared))))
        }
    }
}

#Preview {
    MapListH()
}
