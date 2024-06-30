//
//  NotificationsCenter.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import NotificationCenter

protocol NotificationsCenterProtocol {
    /**
     func notificationPermisions() async
     Asks permisions to the user to show badge notifications to the app icon
     */
    @Sendable func notificationPermisions() async
    /**
     func setBadgeCount(to value: Int) async
     Sets an integer value to the badge
     - parameter value: The integer value to show in the badge
     */
    @Sendable func setBadgeCount(to value: Int) async
}

final class NotificationsCenter {
    private let center: UNUserNotificationCenter

    init(center: UNUserNotificationCenter) {
        self.center = center
    }
}

extension NotificationsCenter: NotificationsCenterProtocol {
    @Sendable
    func notificationPermisions() async {
        do {
            try await center.requestAuthorization(options: .badge)
        } catch {
            print("UNUserNotificationCenter error: \(error)")
        }
    }

    @Sendable
    func setBadgeCount(to value: Int) async {
        do {
            try await center.setBadgeCount(value)
        } catch {
            print("UNUserNotificationCenter error: \(error)")
        }
    }
}
