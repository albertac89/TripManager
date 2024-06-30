//
//  ContactViewBuilder.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 28/6/24.
//

import NotificationCenter

struct ContactViewBuilder {
    /**
     static func build() -> ContactView
     Build the ContactView with all the dependencies
     - returns: A ContactView with all the dependencies injected
     */
    @MainActor
    static func build() -> ContactView {
        let notificationCenter = NotificationsCenter(center: UNUserNotificationCenter.current())
        let userDefaultsManager = UserDefaultsManager()
        let viewModel = ContactViewModel(notificationsCenter: notificationCenter, userDefaultsManager: userDefaultsManager)
        return ContactView(viewModel: viewModel)
    }
}
