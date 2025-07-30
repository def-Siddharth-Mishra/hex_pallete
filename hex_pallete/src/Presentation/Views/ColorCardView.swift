//
//  ColorCardView.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import SwiftUI

struct ColorCardView: View {
    let color: HexColor

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color(hex: color.hex))
                .frame(height: 100)
                .cornerRadius(12)
                .overlay(
                    Text(color.hex)
                        .foregroundColor(.white)
                        .bold()
                        .padding(6),
                    alignment: .bottomTrailing
                )
            Text("Synced: \(color.isSynced ? "✅" : "❌")")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}
