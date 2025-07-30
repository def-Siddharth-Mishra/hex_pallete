import SwiftUI

struct ColorListView: View {
    @StateObject private var viewModel = ColorListViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                HStack {
                    Circle()
                        .fill(viewModel.isConnected ? Color.green : Color.red)
                        .frame(width: 12, height: 12)
                    Text(viewModel.isConnected ? "Online" : "Offline")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.colors.reversed()) { color in
                            ColorCardView(color: color)
                        }
                    }.padding(.top)
                }

                Button(action: {
                    viewModel.generateRandomColor()
                }) {
                    Text("Generate Random Color")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Hex Colors")
        }
    }
}
