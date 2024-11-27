//
//  RecipeRow.swift
//  Fetch_Take_Home
//
//  Created by angusyi on 11/26/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                if let smallPhoto = recipe.photoURLSmall, let url = URL(string: smallPhoto) {
                    WebImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                            .frame(width: 80, height: 80)
                    }
                    .onSuccess { image, data, cacheType in
                        print("Image loaded: \(image), Cache type: \(cacheType == .disk ? "from cache" : "from network")")
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    
                    
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                Spacer()
                
                if let sourceURL = recipe.sourceURL, let url = URL(string: sourceURL) {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "book.fill")
                                .font(.footnote)
                                .foregroundColor(.white)
                            
                            Text("View Recipe")
                                .font(.footnote)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.blue.opacity(0.9))
                }
                
                // YouTube Button
                if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "play.rectangle.fill")
                                .font(.footnote)
                                .foregroundColor(.white)
                            
                            Text("YouTube")
                                .font(.footnote)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.red.opacity(0.9))
                }
            }
        }
        .padding(.vertical, 8)
    }
}
