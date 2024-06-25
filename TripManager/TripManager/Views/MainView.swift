//
//  MainView.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI

struct MainView: View {
    @State var orientation = UIDevice.current.orientation
    private let orientationObserver = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()

    var body: some View {
        NavigationStack {
            Group {
                if orientation.isLandscape {
                    MapListH()
                } else {
                    MapListV()
                }
            }
            .navigationTitle("TripManager")
            .navigationBarTitleDisplayMode(.inline)
        }.onReceive(orientationObserver) { _ in
            self.orientation = UIDevice.current.orientation
        }
    }
}

#Preview {
    MainView()
}
