//
//  Stop.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 26/6/24.
//

import Foundation

struct Stop: Codable {
    let price: Double
    let address: String
    let tripId: Int
    let paid: Bool
    let stopTime: String
    let point: Point
    let userName: String
    var priceFormated: String? {
        price.currencyFormat
    }
    var stopTimeFormated: String? {
        stopTime.dateFormat?.formatted()
    }


    struct Point: Codable {
        let latitude: Double
        let longitude: Double

        enum CodingKeys: String, CodingKey {
            case latitude = "_latitude"
            case longitude = "_longitude"
        }
    }
}
