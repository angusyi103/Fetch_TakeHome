//
//  RecipeViewModelTests.swift
//  Fetch_Take_Home
//
//  Created by angusyi on 11/27/24.
//

import XCTest
@testable import Fetch_Take_Home

final class RecipeViewModelFetchTests: XCTestCase {
    var viewModel: RecipeViewModel!

    override func setUp() {
        super.setUp()
        viewModel = RecipeViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // Test the fetch with a valid endpoint
    func testFetchRecipesSuccess() async {
        viewModel.selectedEndpoint = "All Recipes"
        await viewModel.fetchRecipes(for: viewModel.selectedEndpoint)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.recipes.isEmpty, "Recipes should not be empty when valid data is fetched.")
    }

    // Test fetching malformed data
    func testFetchRecipesMalformedData() async {
        viewModel.selectedEndpoint = "Malformed Data"
        await viewModel.fetchRecipes(for: viewModel.selectedEndpoint)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set when data is malformed.")
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty when data is malformed.")
    }

    // Test fetching empty data
    func testFetchRecipesEmptyData() async {
        viewModel.selectedEndpoint = "Empty Data"
        await viewModel.fetchRecipes(for: viewModel.selectedEndpoint)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil for empty but valid data.")
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty when no data is returned.")
    }

    // Test fetching invalid URL
    func testFetchRecipesInvalidURL() async {
        viewModel.selectedEndpoint = "Invalid Data"  
        await viewModel.fetchRecipes(for: viewModel.selectedEndpoint)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "Invalid endpoint", "Error message should match the expected value for an invalid endpoint.")
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty for an invalid endpoint.")
    }

    // Test for empty URL scenario
    func testFetchRecipesEmptyURL() async {
        viewModel.selectedEndpoint = ""
        await viewModel.fetchRecipes(for: viewModel.selectedEndpoint)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "Invalid endpoint", "Error message should match the expected value for an empty URL.")
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty for an empty URL.")
    }
    
    // Test switching the endpoint
    func testSwitchEndpoint() {
        // Initial endpoint
        XCTAssertEqual(viewModel.selectedEndpoint, "All Recipes")

        // Switch to the next endpoint
        viewModel.switchEndpoint()
        XCTAssertEqual(viewModel.selectedEndpoint, "Malformed Data")

        // Switch to the next endpoint again
        viewModel.switchEndpoint()
        XCTAssertEqual(viewModel.selectedEndpoint, "Empty Data")

        // Switch back to the first endpoint
        viewModel.switchEndpoint()
        XCTAssertEqual(viewModel.selectedEndpoint, "All Recipes")
    }
}
