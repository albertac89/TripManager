//
//  MainViewBuilder.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 28/6/24.
//

import NotificationCenter

struct MainViewBuilder {
    /**
     static func build() -> MainView
     Build the MainView with all the dependencies
     - returns: A MainView with all the dependencies injected
     */
    static func build() -> MainView {
        let notificationsCenter = NotificationsCenter(center: UNUserNotificationCenter.current())
        return MainView(notificationsCenter: notificationsCenter)
    }
}
