//
//  MainView.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI

struct MainView: View {
    let notificationsCenter: NotificationsCenterProtocol
    @State private var orientation = UIDevice.current.orientation
    @State private var path = [Destination]()
    private let orientationObserver = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()

    enum Destination {
        case contactForm
    }

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if orientation.isLandscape {
                    MapListHView()
                } else {
                    MapListVView()
                }
            }
            .navigationTitle(Strings.Navigation.appTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        path.append(.contactForm)
                    } label: {
                        Text(Strings.Navigation.contactButton)
                        Spacer()
                    }
                    .padding(1)
                    .background(.whiteOnDark)
                    .foregroundStyle(.darkOnDark)
                    .clipShape(Capsule())
                    .shadow(radius: 3)
                }
            }.navigationDestination(for: Destination.self) { selection in
                switch selection {
                case .contactForm:
                    ContactViewBuilder.build()
                        .navigationTitle(Strings.Navigation.contactFormTitle)
                }
            }
        }
        .tint(.whiteOnDark)
        .onReceive(orientationObserver) { _ in
            self.orientation = UIDevice.current.orientation
        }
        .task(notificationsCenter.notificationPermisions)
    }
}

#Preview {
    MainViewBuilder.build()
}
