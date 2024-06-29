//
//  Extensions.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

import MapKit

extension MKMapRect: Equatable {
    public static func == (lhs: MKMapRect, rhs: MKMapRect) -> Bool {
        lhs.origin.coordinate == rhs.origin.coordinate && lhs.size == rhs.size
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension MKMapSize: Equatable {
    public static func == (lhs: MKMapSize, rhs: MKMapSize) -> Bool {
        lhs.height == rhs.height && rhs.width == lhs.width
    }
}
