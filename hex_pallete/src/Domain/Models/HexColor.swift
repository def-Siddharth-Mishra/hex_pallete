//
//  HexColor.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import Foundation

struct HexColor: Identifiable, Codable {
    let id: String
    let hex: String
    let timestamp: Date
    var isSynced: Bool

    init(hex: String, timestamp: Date = Date(), isSynced: Bool = false) {
        self.id = UUID().uuidString
        self.hex = hex
        self.timestamp = timestamp
        self.isSynced = isSynced
    }
}
