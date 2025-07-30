//
//  FirebaseService.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import Foundation
import Firebase
import FirebaseFirestore

final class FirebaseService {
    private let db = Firestore.firestore()
    private let collection = "hex_colors"

    func saveColor(_ color: HexColor) async throws {
        let data: [String: Any] = [
            "id": color.id,
            "hex": color.hex,
            "timestamp": color.timestamp
        ]
        try await db.collection(collection).document(color.id).setData(data)
    }
}
