//
//  DetailView.swift
//  MPlay
//
//  Created by maputh on 20/02/25.
//

import SwiftUI

struct DetailView: View {
    let game: Game
    @State private var isAdded = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: game.background_image ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 250)
                                .background(Color.gray.opacity(0.3))

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .clipped()

                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .frame(height: 250)
                                .foregroundColor(.gray)
                                .background(Color.gray.opacity(0.3))

                        @unknown default:
                            EmptyView()
                        }
                    }

                    Text(game.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("\(game.esrb_rating?.name ?? ""), \(Helper.formatDate(game.released ?? ""))")
                        .font(.body)
                        .bold()
                        .foregroundColor(.white)
                    
                    HStack(spacing: 2) {
                        ForEach(0..<Int(game.rating), id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }

                        if game.rating.truncatingRemainder(dividingBy: 1) != 0 {
                            Image(systemName: "star.leadinghalf.filled")
                                .foregroundColor(.yellow)
                        }

                        Text("\(game.rating, specifier: "%.1f") / \(game.rating_top)")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    
                    Button(action: {
                        if isAdded {
                            CoreDataManager.shared.removeFromWatchlist(id: game.id)
                        } else {
                            CoreDataManager.shared.addToWatchlist(
                                id: game.id,
                                title: game.name,
                                image: game.background_image,
                                releaseDate: game.released,
                                rating: game.rating
                            )
                        }
                        isAdded.toggle()
                    }) {
                        Text(isAdded ? "Remove from Watchlist" : "Add to Watchlist")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isAdded ? Color.white : Color.orange)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle(game.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
        .onAppear {
            let watchlist = CoreDataManager.shared.getWatchlist()
            isAdded = watchlist.contains { $0.id == game.id }
        }
    }
}
