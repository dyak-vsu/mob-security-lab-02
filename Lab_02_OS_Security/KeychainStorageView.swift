//
//  KeychainStorageView.swift
//  Lab_02_OS_Security
//
//  Created by Daniil on 30.03.2026.
//

import SwiftUI

struct KeychainStorageView: View {
    @State private var tokenInput = ""
    @State private var output = ""

    var body: some View {
        NavigationView {
            Form {
                Section("Токен") {
                    Text(tokenInput)
                        .textSelection(.enabled)
                    Button("Сгенерировать токен") {
                        tokenInput = UUID().uuidString
                    }
                }

                Section("Keychain") {
                    Button("Сохранить в Keychain") {
                        let result = KeychainManager.shared.saveToken(
                            token: tokenInput
                        )

                        switch result {
                        case .success:
                            output = "Токен сохранён в Keychain"
                        case .failure(let error):
                            output = error.localizedDescription
                        }
                    }

                    Button("Прочитать из Keychain") {
                        let result = KeychainManager.shared.readToken()

                        switch result {
                        case .success(let token):
                            output = "Keychain token: \(token)"
                        case .failure(let error):
                            output = error.localizedDescription
                        }
                    }

                    Button("Удалить из Keychain", role: .destructive) {
                        let result = KeychainManager.shared.deleteToken()

                        switch result {
                        case .success:
                            output = "Токен удалён из Keychain"
                        case .failure(let error):
                            output = error.localizedDescription
                        }
                    }
                }

                Section("Результат") {
                    Text(output)
                        .textSelection(.enabled)
                }
            }
            .navigationTitle("Keychain")
        }
    }
}
