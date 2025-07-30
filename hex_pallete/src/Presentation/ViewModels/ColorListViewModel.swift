//
//  ColorListViewModel.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import Foundation
import Combine

final class ColorListViewModel: ObservableObject {
    @Published var colors: [HexColor] = []
    @Published var isConnected: Bool = true

    private let repository: ColorRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: ColorRepository = ColorRepositoryImpl()) {
        self.repository = repository
        self.colors = repository.getLocalColors()

        observeNetwork()
    }

    private func observeNetwork() {
        NetworkMonitor.shared.$isConnected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.isConnected = status
            }
            .store(in: &cancellables)
    }

    func generateRandomColor() {
        let hex = RandomHexGenerator.generateHexColor()
        let newColor = HexColor(hex: hex)
        repository.saveLocally(newColor)
        colors = repository.getLocalColors()

        if isConnected {
            Task {
                do {
                    try await repository.saveToFirebase(newColor)
                    var syncedColor = newColor
                    syncedColor.isSynced = true
                    repository.updateLocalColor(syncedColor)
                    colors = repository.getLocalColors()
                } catch {
                    print("Failed to sync color immediately: \(error)")
                }
            }
        }
    }
}
