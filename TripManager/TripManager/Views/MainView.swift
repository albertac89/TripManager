//
//  MainView.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI

struct MainView: View {
    let notificationsCenter: NotificationsCenterProtocol
    @State var orientation = UIDevice.current.orientation
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
            .navigationTitle("TripManager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Contact") {
                        path.append(.contactForm)
                    }
                }
            }.navigationDestination(for: Destination.self) { selection in
                switch selection {
                case .contactForm:
                    ContactView(viewModel: ContactViewModel(notificationsCenter: NotificationsCenter(center: UNUserNotificationCenter.current())))
                        .navigationTitle("Contact form")
                }
            }
        }
        .tint(.whiteOnDark)
        .onReceive(orientationObserver) { _ in
            self.orientation = UIDevice.current.orientation // TODO fix scope reset when rotate
        }
        .task(notificationsCenter.notificationPermisions)
    }
}

#Preview {
    MainView(notificationsCenter: NotificationsCenter(center: UNUserNotificationCenter.current()))
}
