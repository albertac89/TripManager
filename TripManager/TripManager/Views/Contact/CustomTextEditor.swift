//
//  CustomTextEditor.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 28/6/24.
//

import SwiftUI

struct CustomTextEditor: View {
    var title: String
    @Binding var text: String
    @Binding var isValid: Bool
    var isMandatory: Bool = false
    @State private var typedCharacters: Int = 0
    @FocusState private var isFocused: Bool

    var body: some View {
        Text(title)
            .listRowSeparator(.hidden)
        VStack {
            TextEditor(text: $text)
                .focused($isFocused)
                .lineLimit(6)
                .multilineTextAlignment(.leading)
                .frame(height: 100)
                .background(.darkOnDark)
                .border(isValid ? .gray : .red)
                .disableAutocorrection(true)
                .onChange(of: text) {
                    typedCharacters = text.count
                }
        }
        HStack {
            Spacer()
            Text("\(typedCharacters) / \(ContactViewModel.descriptionCharactersLimit)")
                .foregroundColor(Color.gray)
        }
    }
}

#Preview {
    CustomTextEditor(title: "Description", text: .constant(""), isValid: .constant(true))
}
