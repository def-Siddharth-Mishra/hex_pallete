//
//  SyncColorsUseCase.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import Foundation

final class SyncColorsUseCase {
    private let repository: ColorRepository

    init(repository: ColorRepository) {
        self.repository = repository
    }

    func execute() async {
        let unsynced = repository.getUnsyncedColors()

        for var color in unsynced {
            do {
                try await repository.saveToFirebase(color)
                color.isSynced = true
                repository.updateLocalColor(color)
            } catch {
                print("Sync failed for \(color.hex): \(error)")
            }
        }
    }
}
