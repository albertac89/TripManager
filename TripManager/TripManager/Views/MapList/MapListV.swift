//
//  MapListV.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI

struct MapListV: View {
    var body: some View {
        VStack {
            MapList(viewModel: MapListViewModel(tripsDataManager: TripsDataManager(api: Api(client: URLSession.shared))))
        }
    }
}

#Preview {
    MapListV()
}
