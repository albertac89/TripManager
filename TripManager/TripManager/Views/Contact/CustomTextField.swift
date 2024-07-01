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
    var type: UIKeyboardType?
    @Binding var text: String
    @Binding var isValid: Bool
    var isMandatory: Bool = false

    var body: some View {
        TextField(title, text: $text)
            .listRowSeparator(.hidden)
            .background(.darkOnDark)
            .border(isValid ? .gray : .red)
            .keyboardType(type ?? .default)
            .submitLabel(.next)
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
    CustomTextField(title: "Test", text: .constant(""), isValid: .constant(true))
}
