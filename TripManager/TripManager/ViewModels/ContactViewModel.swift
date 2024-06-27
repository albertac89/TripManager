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

    let descriptionCharactersLimit = 200
    private let notificationsCenter: NotificationsCenterProtocol

    init(notificationsCenter: NotificationsCenterProtocol) {
        self.notificationsCenter = notificationsCenter
    }
}

extension ContactViewModel {
    private func limitDescriptionCharacters() {
        if form.description.count > descriptionCharactersLimit {
            form.description = String(form.description.prefix(descriptionCharactersLimit))
        }
    }

    func submit() async { // TODO go back to main view after sending the form
        if form.isValid {
            if let data = UserDefaults.standard.object(forKey: UserDefaultsKeys.form) as? Data,
                var forms = try? JSONDecoder().decode([Contact].self, from: data) {
                forms.append(form)
                if let encoded = try? JSONEncoder().encode(forms) {
                    UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.form)
                }
                await notificationsCenter.setBadgeCount(to: forms.count)
            } else {
                if let encoded = try? JSONEncoder().encode([form]) {
                    UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.form)
                }
                await notificationsCenter.setBadgeCount(to: 1)
            }
            resetForm()
        }
    }

    private func resetForm() {
        form = Contact(name: "", surname: "", email: "", phone: "", date: Date.now, description: "")
    }
}