//
//  ColorRepositoryImpl.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import Foundation

final class ColorRepositoryImpl: ColorRepository {
    private var localStorage = LocalStorageService()
    private var firebase = FirebaseService()

    private var localColors: [HexColor] = []

    init() {
        self.localColors = localStorage.load()
    }

    func saveLocally(_ color: HexColor) {
        localColors.append(color)
        localStorage.save(localColors)
    }

    func getLocalColors() -> [HexColor] {
        return localColors
    }

    func getUnsyncedColors() -> [HexColor] {
        return localColors.filter { !$0.isSynced }
    }

    func updateLocalColor(_ updatedColor: HexColor) {
        if let index = localColors.firstIndex(where: { $0.id == updatedColor.id }) {
            localColors[index] = updatedColor
            localStorage.save(localColors)
        }
    }

    func saveToFirebase(_ color: HexColor) async throws {
        try await firebase.saveColor(color)
    }
}
