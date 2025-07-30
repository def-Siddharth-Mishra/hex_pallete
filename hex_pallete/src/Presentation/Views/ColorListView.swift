//
//  ColorListView.swift
//  hex_pallete
//
//  Created by Siddharth Mishra on 30/07/25.
//


import SwiftUI

struct ColorListView: View {
    @StateObject private var viewModel = ColorListViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                VStack(spacing: 12) {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.colors.reversed()) { color in
                                ColorCardView(color: color)
                                    .transition(.move(edge: .leading).combined(with: .opacity))
                            }
                        }
                        .padding(.top)
                    }
                }
                .navigationTitle("Hex Colors")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack(spacing: 6) {
                            Circle()
                                .fill(viewModel.isConnected ? Color.green : Color.red)
                                .frame(width: 12, height: 12)
                                .accessibilityLabel(viewModel.isConnected ? "Online" : "Offline")
                            Text(viewModel.isConnected ? "Online" : "Offline")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .accessibilityHidden(true)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation {
                                viewModel.generateRandomColor()
                            }
                        }) {
                            Label("Generate Random Color", systemImage: "plus.circle.fill")
                        }
                        .accessibilityLabel("Generate Random Color")
                    }
                }
            }
        }
    }
}
