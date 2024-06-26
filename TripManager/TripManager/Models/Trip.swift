//
//  Trip.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import Foundation
import MapKit

struct Trip: Codable, Identifiable, Hashable {
    var id: UUID { UUID() }
    let driverName: String
    let status: String
    let startTime: String
    let origin: LocationPoint
    let description: String
    let destination: LocationPoint
    let stops: [Stop]
    var route: [CLLocationCoordinate2D] {
        var route = stops.compactMap { $0.point?.coordinate }
        route.insert(origin.point.coordinate, at: 0)
        route.insert(destination.point.coordinate, at: route.count)
        return route
    }

    struct LocationPoint: Codable, Hashable {
        let address: String
        let point: Point

        static func == (lhs: LocationPoint, rhs: LocationPoint) -> Bool {
            lhs.address == rhs.address && lhs.point == rhs.point
        }
    }

    struct Point: Codable, Hashable {
        let latitude: Double
        let longitude: Double
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }

        enum CodingKeys: String, CodingKey {
            case latitude = "_latitude"
            case longitude = "_longitude"
        }
    }

    struct Stop: Codable, Identifiable, Hashable {
        let point: Point?
        let id: Int?
    }
}
