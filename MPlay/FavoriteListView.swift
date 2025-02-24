//
//  FavoriteListView.swift
//  MPlay
//
//  Created by maputh on 24/02/25.
//

import SwiftUI

struct FavoriteListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(entity: Watchlist.entity(), sortDescriptors: []) var watchlist: FetchedResults<Watchlist>
        
        var body: some View {
            NavigationStack {
                List {
                    ForEach(watchlist) { item in
                        HStack {
                            AsyncImage(url: URL(string: item.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)

                            Text(item.title ?? "Unknown")
                                .foregroundColor(.white)
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .navigationTitle("Watchlist")
                .background(Color.black.ignoresSafeArea())
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
