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
                CustomTextField(title: Strings.nameField,
                                text: $viewModel.form.name,
                                isValid: $viewModel.isNameValid,
                                isMandatory: true)
                CustomTextField(title: Strings.surnameField,
                                text: $viewModel.form.surname,
                                isValid: $viewModel.isSurnameValid,
                                isMandatory: true)
                CustomTextField(title: Strings.emailField,
                                type: .emailAddress,
                                text: $viewModel.form.email,
                                isValid: $viewModel.isEmailValid,
                                isMandatory: true)
                CustomTextField(title: Strings.phoneField,
                                type: .numberPad,
                                text: $viewModel.form.phone,
                                isValid: .constant(true))
                CustomDatePicker(title: Strings.dateField,
                                 date: $viewModel.form.date,
                                 isValid: $viewModel.isDateValid, 
                                 changedDate: $viewModel.isDateCanged,
                                 isMandatory: true)
                CustomTextEditor(title: Strings.descriptionField,
                                 text: $viewModel.form.description, 
                                 isValid: $viewModel.isDescriptionValid,
                                 isMandatory: true)
                .listRowSeparator(.hidden)
                Button {
                    Task {
                        await viewModel.submit()
                    }
                } label: {
                    Text(Strings.sumbitButton)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.bordered)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            }
        }
        .alert(Strings.Alert.formSentAlert, isPresented: $viewModel.showFormSent) {
            Button(Strings.Alert.ok, role: .cancel) {
                dismiss()
            }
        }
        .alert(Strings.Alert.requiredFieldsAlert, isPresented: $viewModel.showRequiredFields) {
            Button(Strings.Alert.ok, role: .cancel) {
                // No action
            }
        }
    }
}

#Preview {
    ContactViewBuilder.build()
}
