//
//  ContentView.swift
//  Lab_02_OS_Security
//
//  Created by Daniil on 30.03.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            UnsafeStorageView()
                .tabItem {
                    Label("Unsafe", systemImage: "exclamationmark.triangle")
                }

            KeychainStorageView()
                .tabItem {
                    Label("Keychain", systemImage: "lock.shield")
                }
        }
    }
}
