//
//  RecipeModelDecodeTests.swift
//  Fetch_Take_Home
//
//  Created by angusyi on 11/27/24.
//

import XCTest
@testable import Fetch_Take_Home

final class RecipeModelDecodingTests: XCTestCase {
    func testRecipeDecoding() throws {
        let json = """
        {
            "recipes": [
                {
                    "cuisine": "Malaysian",
                    "name": "Apam Balik",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                    "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                    "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                }
            ]
        }
        """
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        let decodedResponse = try decoder.decode(RecipesResponse.self, from: data)
        
        XCTAssertEqual(decodedResponse.recipes.count, 1)
        XCTAssertEqual(decodedResponse.recipes[0].cuisine, "Malaysian")
        XCTAssertEqual(decodedResponse.recipes[0].name, "Apam Balik")
        XCTAssertEqual(decodedResponse.recipes[0].photoURLLarge, "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        XCTAssertEqual(decodedResponse.recipes[0].youtubeURL, "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    }
}
