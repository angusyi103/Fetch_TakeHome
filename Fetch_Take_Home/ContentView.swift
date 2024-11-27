import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    private let endpoints = [
        "All Recipes": "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json",
        "Malformed Data": "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json",
        "Empty Data": "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    ]
    
    @State private var selectedEndpoint: String = "All Recipes"
    @State private var selectedCuisine: String = "All Cuisines"
    
    var cuisines: [String] {
        let allCuisines = viewModel.recipes.map { $0.cuisine }
        return ["All Cuisines"] + Array(Set(allCuisines)).sorted()
    }
    
    var filteredRecipes: [Recipe] {
        if selectedCuisine == "All Cuisines" {
            return viewModel.recipes
        }
        return viewModel.recipes.filter { $0.cuisine == selectedCuisine }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Picker("Select Cuisine", selection: $selectedCuisine) {
                        ForEach(cuisines, id: \.self) { cuisine in
                            Text(cuisine).tag(cuisine)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .tint(.gray)
                    .frame(height: 20)
                    .padding(.trailing)
                }
                
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .padding()
                    }
                    
                    List {
                        if let _ = viewModel.errorMessage {
                            Text("Could Not Load Data. Please Try Again.")
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        else if viewModel.recipes.isEmpty {
                            Text("No recipes found.")
                                .foregroundColor(.secondary)
                                .padding()
                        }
                        else {
                            LazyVStack {
                                ForEach(filteredRecipes) { recipe in
                                    RecipeRow(recipe: recipe)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        switchEndpoint()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Recipes")
            .onAppear {
                viewModel.fetchRecipes(from: endpoints[selectedEndpoint] ?? "")
            }
            .onChange(of: selectedEndpoint) { newValue in
                viewModel.fetchRecipes(from: endpoints[newValue] ?? "")
            }
        }
    }
    
    private func switchEndpoint() {
        let endpointKeys = Array(endpoints.keys)
        if let currentIndex = endpointKeys.firstIndex(of: selectedEndpoint) {
            let nextIndex = (currentIndex + 1) % endpointKeys.count
            selectedEndpoint = endpointKeys[nextIndex]
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
