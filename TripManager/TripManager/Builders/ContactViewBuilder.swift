//
//  ContactViewBuilder.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 28/6/24.
//

import NotificationCenter

struct ContactViewBuilder {
    @MainActor 
    static func build() -> ContactView {
        let notificationCenter = NotificationsCenter(center: UNUserNotificationCenter.current())
        let userDefaultsManager = UserDefaultsManager()
        let viewModel = ContactViewModel(notificationsCenter: notificationCenter, userDefaultsManager: userDefaultsManager)
        return ContactView(viewModel: viewModel)
    }
}
