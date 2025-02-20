//
//  GameViewModel.swift
//  MPlay
//
//  Created by maputh on 20/02/25.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadGames() {
        Task {
            do {
                isLoading = true
                games = try await GameService.shared.fetchGames()
                isLoading = false
            } catch {
                print("Error fetching games: \(error)")
                errorMessage = "Gagal memuat game. Coba lagi nanti ya!"
                isLoading = false
            }
        }
    }
}
