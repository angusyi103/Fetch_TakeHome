import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
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
                        viewModel.switchEndpoint()
                        await viewModel.fetchRecipes(for: viewModel.selectedEndpoint)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.fetchRecipes(for: viewModel.selectedEndpoint)
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
