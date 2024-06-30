//
//  ContactViewModel.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 27/6/24.
//

import SwiftUI

@MainActor
final class ContactViewModel: ObservableObject {
    @Published var form = Contact(name: "", surname: "", email: "", phone: "", date: Date.now, description: "") {
        didSet {
            limitDescriptionCharacters()
        }
    }
    @Published var isNameValid = true
    @Published var isSurnameValid = true
    @Published var isEmailValid = true
    @Published var isDateValid = true
    @Published var isDateCanged = false
    @Published var isDescriptionValid = true
    @Published var showRequiredFields = false
    @Published var showFormSent = false

    static let descriptionCharactersLimit = 200
    private let notificationsCenter: NotificationsCenterProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol

    init(notificationsCenter: NotificationsCenterProtocol, userDefaultsManager: UserDefaultsManagerProtocol) {
        self.notificationsCenter = notificationsCenter
        self.userDefaultsManager = userDefaultsManager
    }
}

extension ContactViewModel {
    /**
     func limitDescriptionCharacters()
     Limits the characters of the description field
     */
    private func limitDescriptionCharacters() {
        if form.description.count > ContactViewModel.descriptionCharactersLimit {
            form.description = String(form.description.prefix(ContactViewModel.descriptionCharactersLimit))
        }
    }

    /**
     func submit() async
     Simulates sending a form, stores the forms in UserDefaults, and sets a badge to show in the app icon how mani contact forms you submited
     */
    func submit() async {
        if validateForm() {
            if var forms = userDefaultsManager.get([Contact].self, valueFor: UserDefaultsKeys.form) {
                forms.append(form)
                userDefaultsManager.set(value: forms, for: UserDefaultsKeys.form)
                await notificationsCenter.setBadgeCount(to: forms.count)
            } else {
                userDefaultsManager.set(value: [form], for: UserDefaultsKeys.form)
                await notificationsCenter.setBadgeCount(to: 1)
            }
            completed()
        } else {
            showRequiredFields = true
        }
    }

    /**
     func validateForm() -> Bool
     Validates the form and updates the @Published values to alert of missing required fields
     - Returns: A Bool whether the form is valid or not
     */
    private func validateForm() -> Bool {
        showRequiredFields = false
        isNameValid = !form.name.isEmpty
        isSurnameValid = !form.surname.isEmpty
        isEmailValid = !form.email.isEmpty
        isDateValid = isDateCanged
        isDescriptionValid = !form.description.isEmpty
        return isNameValid && isSurnameValid && isEmailValid && isDateValid && isDescriptionValid
    }

    /**
     func completed()
     Sets the @Published var showFormSent to true, to show an alert of form sent
     */
    private func completed() {
        showFormSent = true
    }
}
