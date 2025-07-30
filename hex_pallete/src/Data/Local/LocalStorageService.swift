//
//  LocalStorageService.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import Foundation

final class LocalStorageService {
    private let userDefaultsKey = "saved_colors"

    func save(_ colors: [HexColor]) {
        if let data = try? JSONEncoder().encode(colors) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    func load() -> [HexColor] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let colors = try? JSONDecoder().decode([HexColor].self, from: data) else {
            return []
        }
        return colors
    }
}
