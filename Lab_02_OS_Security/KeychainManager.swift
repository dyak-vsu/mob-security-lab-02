//
//  KeychainManager.swift
//  Lab_02_OS_Security
//
//  Created by Daniil on 30.03.2026.
//

import Foundation
import Security

final class KeychainManager {
    static let shared = KeychainManager()

    private let service = "demo.token.KeyChain"
    private let account = "demoToken"

    private init() {}

    func saveToken(token: String) -> Result<Void, KeychainError> {
        let data = Data(token.utf8)

        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(deleteQuery as CFDictionary)

        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
        ]

        let status = SecItemAdd(addQuery as CFDictionary, nil)

        guard status == errSecSuccess else {
            return .failure(.unhandledError(status: status))
        }

        return .success(())
    }

    func readToken() -> Result<String, KeychainError> {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else {
            return .failure(.unhandledError(status: status))
        }

        guard let data = item as? Data else {
            return .failure(.noData)
        }

        guard let token = String(data: data, encoding: .utf8) else {
            return .failure(.invalidData)
        }

        return .success(token)
    }

    func deleteToken() -> Result<Void, KeychainError> {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let status = SecItemDelete(query as CFDictionary)

        if status == errSecSuccess || status == errSecItemNotFound {
            return .success(())
        } else {
            return .failure(.unhandledError(status: status))
        }
    }
}
