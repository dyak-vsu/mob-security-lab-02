//
//  KeychainError.swift
//  Lab_02_OS_Security
//
//  Created by Daniil on 01.04.2026.
//

import Foundation
import Security

enum KeychainError: Error, LocalizedError {
    case unhandledError(status: OSStatus)
    case noData
    case invalidData

    var errorDescription: String? {
        switch self {
        case .unhandledError(let status):
            if let message = SecCopyErrorMessageString(status, nil) as String? {
                return "OSStatus \(status): \(message)"
            } else {
                return "OSStatus \(status)"
            }
        case .noData:
            return "Данные не найдены"
        case .invalidData:
            return "Невалидные данные"
        }
    }
}
