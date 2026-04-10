//
//  UnsafeStorageView.swift
//  Lab_02_OS_Security
//
//  Created by Daniil on 30.03.2026.
//

import SwiftUI

struct UnsafeStorageView: View {
    @State private var tokenInput = ""
    @State private var output = ""
    @State private var filePath = ""

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

                Section("Действия") {
                    Button("Сохранить в UserDefaults") {
                        UnsafeStorageManager.shared.saveToUserDefaults(tokenInput)
                        output = "Сохранено в UserDefaults"
                    }

                    Button("Сохранить в файл") {
                        do {
                            try UnsafeStorageManager.shared.saveToFile(tokenInput)
                            let path = UnsafeStorageManager.shared.fileURL().path
                            filePath = path
                            output = "Сохранено в файл"
                        } catch {
                            output = "Ошибка записи в файл: \(error.localizedDescription)"
                        }
                    }

                    Button("Прочитать UserDefaults") {
                        if let token = UnsafeStorageManager.shared.readFromUserDefaults() {
                            output = "UserDefaults token: \(token)"
                        } else {
                            output = "В UserDefaults токен не найден"
                        }
                    }

                    Button("Прочитать файл") {
                        do {
                            let token = try UnsafeStorageManager.shared.readFromFile()
                            filePath = UnsafeStorageManager.shared.fileURL().path
                            output = "File token: \(token)"
                        } catch {
                            output = "Ошибка чтения файла: \(error.localizedDescription)"
                        }
                    }
                }

                Section("Результат") {
                    Text(output)
                        .textSelection(.enabled)
                }
            }
            .navigationTitle("Unsafe Storage")
        }
    }
}
