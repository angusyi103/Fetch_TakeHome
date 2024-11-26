//
//  ContentView.swift
//  Fetch_Take_Home
//
//  Created by angusyi on 11/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    // Allow endpoint switching for testing different scenarios
    private let endpoints = [
        "All Recipes": "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json",
        "Malformed Data": "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json",
        "Empty Data": "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    ]
    @State private var selectedEndpoint: String = "All Recipes"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Dropdown to select endpoint
                Picker("Test Scenario", selection: $selectedEndpoint) {
                    ForEach(endpoints.keys.sorted(), id: \.self) { key in
                        Text(key).tag(key)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selectedEndpoint) { newValue in
                    if let url = endpoints[newValue] {
                        viewModel.fetchRecipes(from: url)
                    }
                }
                
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .padding()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else if viewModel.recipes.isEmpty {
                        VStack {
                            Spacer()
                            Text("No recipes found.")
                                .foregroundColor(.secondary)
                                .padding()
                            Spacer()
                        }
                    } else {
                        List(viewModel.recipes) { recipe in
                            RecipeRow(recipe: recipe)
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Recipes")
            .onAppear {
                if let url = endpoints[selectedEndpoint] {
                    viewModel.fetchRecipes(from: url)
                }
            }
        }
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                if let smallPhoto = recipe.photoURLSmall, let url = URL(string: smallPhoto) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        } else if phase.error != nil {
                            Color.red.frame(width: 100, height: 100)
                        } else {
                            ProgressView().frame(width: 100, height: 100)
                        }
                    }
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
                        Text("View Recipe")
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .padding(.trailing, 10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                // YouTube Button
                if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                    Button(action: {
                        UIApplication.shared.open(url)
                    }) {
                        HStack(spacing: 3) {
                            Image(systemName: "play.rectangle.fill")
                                .foregroundColor(.red)
                            Text("YouTube")
                                .font(.footnote)
                                .foregroundColor(.red)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(.vertical, 8)
        
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
