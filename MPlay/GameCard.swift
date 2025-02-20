//
//  GameCard.swift
//  MPlay
//
//  Created by maputh on 20/02/25.
//

import SwiftUI

struct GameCard: View {
    let game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: game.background_image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .frame(width: .infinity)
                        .clipped()
                        .cornerRadius(10)

                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(game.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Text(Helper.formatDate(game.released ?? ""))
                    .foregroundColor(.white)
                    .font(.caption)
                
            HStack(spacing: 2) {
                ForEach(0..<Int(game.rating), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }

                if game.rating.truncatingRemainder(dividingBy: 1) != 0 {
                    Image(systemName: "star.leadinghalf.filled")
                        .foregroundColor(.yellow)
                }

                Text("\(game.rating, specifier: "%.1f")")
                    .foregroundColor(.white)
                    .font(.caption)
            }
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(
                    colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .shadow(radius: 5)
        )
        .cornerRadius(15)
        .padding(.horizontal) // Tambahkan padding supaya tidak terlalu mepet
    }
}
