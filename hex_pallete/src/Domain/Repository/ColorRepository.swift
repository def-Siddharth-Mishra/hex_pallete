//
//  ColorRepository.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import Foundation
import Combine

protocol ColorRepository {
    func saveLocally(_ color: HexColor)
    func getLocalColors() -> [HexColor]
    func saveToFirebase(_ color: HexColor) async throws
    func updateLocalColor(_ color: HexColor)
    func getUnsyncedColors() -> [HexColor]
}
