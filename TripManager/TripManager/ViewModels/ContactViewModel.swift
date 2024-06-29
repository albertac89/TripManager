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
    private func limitDescriptionCharacters() {
        if form.description.count > ContactViewModel.descriptionCharactersLimit {
            form.description = String(form.description.prefix(ContactViewModel.descriptionCharactersLimit))
        }
    }

    func submit() async {
        if form.isValid {
            if var forms = userDefaultsManager.get([Contact].self, valueFor: UserDefaultsKeys.form) {
                forms.append(form)
                userDefaultsManager.set(value: forms, for: UserDefaultsKeys.form)
                await notificationsCenter.setBadgeCount(to: forms.count)
            } else {
                userDefaultsManager.set(value: [form], for: UserDefaultsKeys.form)
                await notificationsCenter.setBadgeCount(to: 1)
            }
            completed()
        }
    }

    private func completed() {
        showFormSent = true
    }
}
