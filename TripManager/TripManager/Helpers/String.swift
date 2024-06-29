//
//  DateFormater.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import Foundation

extension String {
    var dateFormat: Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
        return dateFormatter.date(from: self)
    }

    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}
