import Foundation

final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedEndpoint: String = "All Recipes"
    
    private let endpoints = [
        "All Recipes": "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json",
        "Malformed Data": "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json",
        "Empty Data": "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    ]
    
    @MainActor
    func fetchRecipes(for selectedEndpoint: String) async {
        guard let urlString = endpoints[selectedEndpoint] else {
            errorMessage = "Invalid endpoint"
            return
        }
        
        print("Fetching from URL: \(urlString)")
        
        guard !urlString.isEmpty else {
            errorMessage = "URL is empty"
            return
        }
        
        guard let url = URL(string: urlString), let _ = url.scheme, let _ = url.host else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
            
            // Updates will automatically happen on the main thread due to @MainActor
            self.recipes = decodedResponse.recipes
            self.isLoading = false
        } catch {
            errorMessage = "Failed to load: \(error.localizedDescription)"
            isLoading = false
        }
    }
    
    // Move the endpoint switch logic here
    func switchEndpoint() {
        let endpointKeys = Array(endpoints.keys)
        if let currentIndex = endpointKeys.firstIndex(of: selectedEndpoint) {
            let nextIndex = (currentIndex + 1) % endpointKeys.count
            selectedEndpoint = endpointKeys[nextIndex]
        }
    }
}
