//
//  DateFormater.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import Foundation

extension String {
    /**
     var dateFormat: Date?
     Formats an ISO8601 string date to Date
     */
    var dateFormat: Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
        return dateFormatter.date(from: self)
    }

    /**
     var isNumber: Bool
     Checks if a string is all numbers
     */
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}
