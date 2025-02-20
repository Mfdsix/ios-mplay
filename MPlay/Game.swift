//
//  Game.swift
//  MPlay
//
//  Created by maputh on 20/02/25.
//

import Foundation

import Foundation

struct GameResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Game]
}

struct Game: Identifiable, Codable {
    let id: Int
    let slug: String
    let name: String
    let released: String?
    let background_image: String?
    let rating: Double
    let rating_top: Int
    let esrb_rating: ESRBRating?
    let platforms: [PlatformInfo]?
}

struct ESRBRating: Codable {
    let id: Int
    let slug: String
    let name: String
}

struct PlatformInfo: Codable {
    let platform: Platform
}

struct Platform: Codable {
    let id: Int
    let slug: String
    let name: String
}
