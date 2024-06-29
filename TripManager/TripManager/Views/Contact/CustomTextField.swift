//
//  CustomTextField.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 28/6/24.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    var placeholder: String?
    @Binding var text: String
    var type: UIKeyboardType?

    var body: some View {
        Text(title)
            .listRowSeparator(.hidden)
        TextField(placeholder ?? "", text: $text)
            .background(.darkOnDark)
            .border(.gray)
            .keyboardType(type ?? .default)
            .onChange(of: text) { oldValue, newValue in
                switch type {
                case .numberPad:
                    if newValue.isNumber {
                        text = newValue
                    } else {
                        text = ""
                    }
                default:
                    text = newValue
                }
            }
    }
}

#Preview {
    CustomTextField(title: "Test", text: .constant(""))
}
