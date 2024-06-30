//
//  UserDefaultsManager.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    /**
     func set<T: Encodable>(value: T, for key: String)
     Stores  a generic object T to the UserDefaults
     - parameter T: The type of the object
     - parameter value: The object to store
     - parameter key: The key to store the object
     */
    func set<T: Encodable>(value: T, for key: String)
    /**
     func get<T: Decodable>(_ type: T.Type, valueFor key: String) -> T?
     Retrives a generic object T from the UserDefaults
     - parameter T: The type of the object
     - parameter type: The type of the object
     - parameter key: The key to retrive the object
     - returns: The stored object of type T
     */
    func get<T: Decodable>(_ type: T.Type, valueFor key: String) -> T?
}

final class UserDefaultsManager: UserDefaultsManagerProtocol {
    func set<T: Encodable>(value: T, for key: String) {
        do {
            let encoded = try JSONEncoder().encode(value)
            UserDefaults.standard.set(encoded, forKey: key)
        } catch {
            print("Error to encode the value for the key \(key): \(error.localizedDescription)")
        }
    }

    func get<T: Decodable>(_ type: T.Type, valueFor key: String) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
            print("No data found for the key \(key)")
            return nil
        }

        do {
            return try JSONDecoder().decode(type.self, from: data)
        } catch {
            print("Error to encode the value for the key \(key): \(error.localizedDescription)")
            return nil
        }
    }
}
