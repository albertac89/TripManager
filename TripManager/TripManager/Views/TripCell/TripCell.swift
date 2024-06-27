//
//  TripCell.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI

struct TripCell: View {
    let trip: Trip
    struct Constants {
        struct Strings {
            static let date = "Date:"
            static let origin = "Origin:"
            static let destination = "Destination:"
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(trip.driverName)
                .font(.system(size: 20))
            if let date = trip.startTimeFormated {
                Text("\(Constants.Strings.date) \(date)")
                    .font(.system(size: 10))
            }
            Text("\(Constants.Strings.origin) \(trip.origin.address)")
                .font(.system(size: 15))
            Text("\(Constants.Strings.destination) \(trip.destination.address)")
                .font(.system(size: 15))
        }
        .padding(10)
    }
}

#Preview {
    TripCell(trip: Trip(driverName: "Albert Aige Cortasa", status: "ongoing", startTime: "2018-12-18T08:00:00.000Z", origin: Trip.LocationPoint(address: "Metropolis:lab, Barcelona", point: Trip.Point(latitude: 41.38074, longitude: 2.18594)), description: "Barcelona a Martorell", destination: Trip.LocationPoint(address: "Seat HQ, Martorell", point: Trip.Point(latitude: 41.49958, longitude: 1.90307)), stops: []))
}
