//
//  ContactView.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import SwiftUI

struct ContactView: View {
    @ObservedObject var viewModel: ContactViewModel
    @State var typedCharacters: Int = 0

    var body: some View {
        VStack {
            Form {
                Text("Name*")
                TextField("", text: $viewModel.form.name)
                    .textFieldStyle(.roundedBorder)
                Text("Surname*")
                TextField("", text: $viewModel.form.surname)
                    .textFieldStyle(.roundedBorder)
                Text("Email*")
                TextField("", text: $viewModel.form.email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                Text("Phone")
                TextField("", text: $viewModel.form.phone)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                DatePicker("Time*", selection: $viewModel.form.date)
                    .onChange(of: viewModel.form.date) {
                        viewModel.form.isValidDate = true
                    }
                Text("Description*") // TODO fix textfield
                TextEditor(text: $viewModel.form.description)
                    .border(.black)
                    .lineLimit(6)
                    .multilineTextAlignment(.leading)
                    .frame(height: 100)
                    .onChange(of: viewModel.form.description) {
                        typedCharacters = viewModel.form.description.count
                    }

                Text("\(typedCharacters) / \(viewModel.descriptionCharactersLimit)")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 240)
                Section {
                    Button("Submit") {
                        Task {
                            await viewModel.submit()
                        }
                    }
                }.disabled(!viewModel.form.isValid)
            }
        }
    }
}

#Preview {
    ContactView(viewModel: ContactViewModel(notificationsCenter: NotificationsCenter(center: UNUserNotificationCenter.current())))
}
