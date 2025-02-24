//
//  GameListView.swift
//  MPlay
//
//  Created by maputh on 24/02/25.
//

import SwiftUI

struct GameListView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        NavigationView {
        ZStack {
            if viewModel.isLoading {
                List(0..<5, id: \.self) { _ in
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 80, height: 80)
                            .shimmer()
                        
                        VStack(alignment: .leading, spacing: 6) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 150, height: 16)
                                .shimmer()
                            
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 100, height: 12)
                                .shimmer()
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
                .background(Color.black)
            } else {
                List(viewModel.games) { game in
                    NavigationLink(destination: DetailView(game: game)) {
                        GameCard(game: game)
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.black)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationTitle("Games for You")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(.white)
        .toolbar {
            NavigationLink(destination: ProfileView()) {
                Image(systemName: "person.circle")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            viewModel.loadGames()
        }
        .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "Terjadi kesalahan."),
                dismissButton: .default(Text("Okeh"), action: {
                    viewModel.errorMessage = nil
                    viewModel.loadGames()
                })
            )
        }
    }
        .preferredColorScheme(.dark)
    }
}
