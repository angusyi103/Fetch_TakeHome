//
//  RecipeModel.swift
//  Fetch_Take_Home
//
//  Created by angusyi on 11/24/24.
//

import Foundation

struct RecipesResponse: Codable {
    let recipes: [Recipe] // Matches the key "recipes" in the JSON
}

struct Recipe: Codable, Identifiable {
    let uuid: String
    let cuisine: String
    let name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?

    var id: String { uuid }

    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
