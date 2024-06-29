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
    @State private var typedCharacters: Int = 0

    var body: some View {
        Text(title)
            .listRowSeparator(.hidden)
        VStack {
            TextEditor(text: $text)
                .lineLimit(6)
                .multilineTextAlignment(.leading)
                .frame(height: 100)
                .background(.darkOnDark)
                .border(.gray)
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
    CustomTextEditor(title: "Description", text: .constant(""))
}
