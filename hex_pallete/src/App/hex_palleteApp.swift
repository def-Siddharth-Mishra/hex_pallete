//
//  hex_palleteApp.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//

import SwiftUI
import Firebase

@main
struct hex_palleteApp: App {
    init() {
        FirebaseApp.configure()
        _ = SyncManager.shared // Start syncing on app launch
    }

    var body: some Scene {
        WindowGroup {
            ColorListView()
        }
    }
}
