//
//  Double+Currency format.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import Foundation

extension Double {
    var currencyFormat: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "€"
        formatter.maximumFractionDigits = 2

        let number = NSNumber(value: self)
        return formatter.string(from: number)
    }
}
