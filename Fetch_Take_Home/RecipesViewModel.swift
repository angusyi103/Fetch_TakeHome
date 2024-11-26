//
//  RecipesViewModel.swift
//  Fetch_Take_Home
//
//  Created by angusyi on 11/24/24.
//

import Foundation
import Combine

final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchRecipes(from urlString: String) {
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: RecipesResponse.self, decoder: JSONDecoder())
            .map(\.recipes)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = "Failed to load: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] recipes in
                self?.recipes = recipes
            })
            .store(in: &cancellables)
    }
}
