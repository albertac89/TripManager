//
//  UserDefaultsManager.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func set<T: Encodable>(value: T, for key: String)
    func get<T: Decodable>(_ type: T.Type, valueFor key: String) -> T?
}

final class UserDefaultsManager: UserDefaultsManagerProtocol {
    func set<T: Encodable>(value: T, for key: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func get<T: Decodable>(_ type: T.Type, valueFor key: String) -> T? {
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            return try? JSONDecoder().decode(type.self, from: data)
        }
        return nil
    }
}
