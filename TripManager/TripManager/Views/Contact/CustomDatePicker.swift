//
//  CustomDatePicker.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 30/6/24.
//

import SwiftUI

struct CustomDatePicker: View {
    var title: String
    @Binding var date: Date
    @Binding var isValid: Bool
    @Binding var changedDate: Bool
    var isMandatory: Bool = false

    var body: some View {
        HStack {
            DatePicker(title, selection: $date)
                .colorMultiply(isValid ? .whiteOnDark : .red)
                .onChange(of: date) {
                    changedDate = true
                }.listRowSeparator(.hidden)
        }
    }
}

#Preview {
    CustomDatePicker(title: "Date", date: .constant(Date.now), isValid: .constant(true), changedDate: .constant(false))
}
