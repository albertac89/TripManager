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
        let viewModel = ContactViewModel(notificationsCenter: notificationCenter)
        return ContactView(viewModel: viewModel)
    }
}
