//
//  Contact.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import Foundation

struct Contact: Codable {
    var name: String
    var surname: String
    var email: String
    var phone: String
    var date: Date
    var description: String

    var isValid: Bool {
        !name.isEmpty && !surname.isEmpty && !email.isEmpty && isValidDate && !description.isEmpty
    }
    var isValidDate = false
}
