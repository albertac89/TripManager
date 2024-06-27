//
//  StopInfoView.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import SwiftUI

struct StopInfoView: View {
    var stop: Stop
    struct Constants {
        struct Strings {
            static let address = "Address:"
            static let date = "Date:"
            static let price = "Price:"
            static let paid = "Paid:"
            static let yes = "Yes"
            static let no = "No"
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(Constants.Strings.address) \(stop.address)")
                .font(.system(size: 12))
            if let date = stop.stopTimeFormated {
                Text("\(Constants.Strings.date) \(date)")
                    .font(.system(size: 12))
            }
            if let amount = stop.priceFormated {
                Text("\(Constants.Strings.price) \(amount)")
                    .font(.system(size: 12))
            }
            Text("\(Constants.Strings.paid) \(stop.paid ? Constants.Strings.yes : Constants.Strings.no)")
                .font(.system(size: 12))
        }
    }
}

#Preview {
    StopInfoView(stop: Stop(price: 10.0, address: "address", tripId: 1, paid: true, stopTime: "2018-12-18T08:00:00.000Z", point: Stop.Point(latitude: 123132.0, longitude: 123132.0), userName: "Albert"))
}
