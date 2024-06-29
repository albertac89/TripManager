//
//  UserDefaultsManagerMock.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

@testable import TripManager

final class UserDefaultsManagerMock: UserDefaultsManagerProtocol {
    var setSpy = 0
    var getSpy = 0
    var getRetrun: Any?

    func set<T>(value: T, for key: String) where T : Encodable {
        setSpy += 1
    }

    func get<T>(_ type: T.Type, valueFor key: String) -> T? where T : Decodable {
        getSpy += 1
        return getRetrun as? T
    }
}
