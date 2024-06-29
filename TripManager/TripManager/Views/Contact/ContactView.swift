//
//  ContactView.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import SwiftUI

struct ContactView: View {
    @ObservedObject var viewModel: ContactViewModel
    @State private var typedCharacters: Int = 0
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Form {
                CustomTextField(title: "Name*",
                                text: $viewModel.form.name)
                CustomTextField(title: "Surname*",
                                text: $viewModel.form.surname)
                CustomTextField(title: "Email*",
                                text: $viewModel.form.email,
                                type: .emailAddress)
                CustomTextField(title: "Phone",
                                text: $viewModel.form.phone,
                                type: .numberPad)
                DatePicker("Time*", selection: $viewModel.form.date)
                    .onChange(of: viewModel.form.date) {
                        viewModel.form.isValidDate = true
                    }.listRowSeparator(.hidden)
                CustomTextEditor(title: "Description*",
                                 text: $viewModel.form.description)
                .listRowSeparator(.hidden)
                Button {
                    Task {
                        await viewModel.submit()
                    }
                } label: {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.bordered)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                .disabled(!viewModel.form.isValid)
            }
        }.alert("Form sent succesfully", isPresented: $viewModel.showFormSent) {
            Button("Return to the map", role: .cancel) {
                dismiss()
            }
        }
    }
}

#Preview {
    ContactViewBuilder.build()
}
