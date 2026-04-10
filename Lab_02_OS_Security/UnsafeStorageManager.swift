//
//  UnsafeStorageManager.swift
//  Lab_02_OS_Security
//
//  Created by Daniil on 30.03.2026.
//

import Foundation

final class UnsafeStorageManager {
    static let shared = UnsafeStorageManager()

    private let userDefaultsKey = "demo.token.userdefaults"
    private let fileName = "token.txt"

    private init() {}


    func saveToUserDefaults(_ token: String) {
        UserDefaults.standard.set(token, forKey: userDefaultsKey)
    }

    func readFromUserDefaults() -> String? {
        UserDefaults.standard.string(forKey: userDefaultsKey)
    }

    func fileURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent(fileName)
    }

    func saveToFile(_ token: String) throws {
        let url = fileURL()
        try token.write(to: url, atomically: true, encoding: .utf8)
    }

    func readFromFile() throws -> String {
        let url = fileURL()
        return try String(contentsOf: url, encoding: .utf8)
    }
}
