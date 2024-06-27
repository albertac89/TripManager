//
//  NotificationsCenter.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import NotificationCenter

protocol NotificationsCenterProtocol {
    @Sendable func notificationPermisions() async
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
