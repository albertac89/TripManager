//
//  Trip.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import Foundation

struct Trip: Codable, Identifiable {
    var id: UUID { UUID() }
    let driverName: String
    let status: String
    let startTime: String
    let origin: LocationPoint
    let description: String
    let destination: LocationPoint
    let stops: [Stop]

    struct LocationPoint: Codable {
        let address: String
        let point: Point
    }

    struct Point: Codable {
        let latitude: Double
        let longitude: Double

        enum CodingKeys: String, CodingKey {
            case latitude = "_latitude"
            case longitude = "_longitude"
        }
    }

    struct Stop: Codable {
        let point: Point?
        let id: Int?
    }
}
