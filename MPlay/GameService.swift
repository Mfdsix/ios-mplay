//
//  GameService.swift
//  MPlay
//
//  Created by maputh on 20/02/25.
//

import Foundation

class GameService {
    static let shared = GameService()
    
    private let apiURL = "https://api.rawg.io/api"
    private let apiKey = "secret"

    func fetchGames() async throws -> [Game] {
        guard let url = URL(string: apiURL + "/games?key=" + apiKey) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON: \(jsonString)")
        }
        let decodedResponse = try JSONDecoder().decode(GameResponse.self, from: data)
        return decodedResponse.results
    }
}


