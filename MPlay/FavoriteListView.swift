//
//  FavoriteListView.swift
//  MPlay
//
//  Created by maputh on 24/02/25.
//

import SwiftUI

struct FavoriteListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var watchlist: [Watchlist] = []
        
        var body: some View {
            NavigationStack {
                List {
                    ForEach(watchlist, id: \.self) { item in
                        NavigationLink(destination: DetailView(game: Game(
                            id: Int(item.id),
                            slug: item.title ?? "unknown",
                            name: item.title ?? "Unknown",
                            released: item.releaseDate,
                            background_image: item.image,
                            rating: item.rating,
                            rating_top: 5,
                            esrb_rating: nil,
                            platforms: []
                        ))) {
                            HStack {
                                AsyncImage(url: URL(string: item.image ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)

                                VStack {
                                    Text(item.title ?? "Unknown")
                                        .foregroundColor(.white)
                                    
                                    Text(Helper.formatDate(item.releaseDate ?? "-"))
                                        .foregroundColor(.white)
                                        .font(.caption)
                                    
                                    HStack(spacing: 2) {
                                        ForEach(0..<Int(item.rating), id: \.self) { _ in
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                        }

                                        if item.rating.truncatingRemainder(dividingBy: 1) != 0 {
                                            Image(systemName: "star.leadinghalf.filled")
                                                .foregroundColor(.yellow)
                                        }

                                        Text("\(item.rating, specifier: "%.1f")")
                                            .foregroundColor(.white)
                                            .font(.caption)
                                    }
                                }
        
                                
                            }
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .navigationTitle("My Favorite")
                .background(Color.black.ignoresSafeArea())
            }
            .onAppear {
                watchlist = CoreDataManager.shared.getWatchlist()
            }
        }
        
        private func deleteItem(at offsets: IndexSet) {
            for index in offsets {
                let item = watchlist[index]
                viewContext.delete(item)
            }
            
            do {
                try viewContext.save()
            } catch {
                print("Failed to delete: \(error.localizedDescription)")
            }
        }
}
