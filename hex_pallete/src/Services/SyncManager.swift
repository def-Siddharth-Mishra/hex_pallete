//
//  SyncManager.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import Foundation
import Combine

final class SyncManager {
    static let shared = SyncManager()

    private let networkMonitor = NetworkMonitor.shared
    private var cancellables = Set<AnyCancellable>()

    private let useCase: SyncColorsUseCase

    private init() {
        let repository = ColorRepositoryImpl()
        self.useCase = SyncColorsUseCase(repository: repository)

        observeNetwork()
    }

    private func observeNetwork() {
        networkMonitor.$isConnected
            .removeDuplicates()
            .sink { [weak self] isConnected in
                if isConnected {
                    Task {
                        await self?.syncColors()
                    }
                }
            }
            .store(in: &cancellables)
    }

    func syncColors() async {
        await useCase.execute()
    }
}
