//
//  TripCell.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI

struct TripCell: View {
    let trip: Trip
    var body: some View {
        VStack(alignment: .leading) {
            Text(trip.driverName)
                .font(.system(size: 20))
            Text("Fecha: \(trip.startTime)")// TODO format date
                .font(.system(size: 10))
            Text("Origen: \(trip.origin.address)")
                .font(.system(size: 15))
            Text("Destinación: \(trip.destination.address)")
                .font(.system(size: 15))
        }
        .padding(10)
    }
}

#Preview {
    TripCell(trip: Trip(driverName: "Albert Aige Cortasa", status: "ongoing", startTime: "2018-12-18T08:00:00.000Z", origin: Trip.LocationPoint(address: "Metropolis:lab, Barcelona", point: Trip.Point(latitude: 41.38074, longitude: 2.18594)), description: "Barcelona a Martorell", destination: Trip.LocationPoint(address: "Seat HQ, Martorell", point: Trip.Point(latitude: 41.49958, longitude: 1.90307)), stops: []))
}
