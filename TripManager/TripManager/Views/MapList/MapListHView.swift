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
            MapListViewBuilder.build()
        }
    }
}

#Preview {
    MapListHView()
}
