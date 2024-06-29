//
//  NotificationsCenterMock.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

@testable import TripManager

final class NotificationsCenterMock: NotificationsCenterProtocol {
    var notificationPermisionsSpy = 0
    var setBadgeCountSpy = 0
    var setBadgeCountValue = 0
    func notificationPermisions() async {
        notificationPermisionsSpy += 1
    }
    
    func setBadgeCount(to value: Int) async {
        setBadgeCountValue = value
        setBadgeCountSpy += 1
    }
}
