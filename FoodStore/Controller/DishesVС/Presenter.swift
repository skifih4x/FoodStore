//
//  Presenter.swift
//  FoodStore
//
//  Created by Артем Орлов on 03.04.2023.
//

import Foundation

protocol RecipeListPresenterProtocol: AnyObject {
    func fetchRecipes()
    func numberOfCategories() -> Int
    func numberOfDishes() -> Int
    func a(row: Int) -> String
    func fetchSelectedCategoryRecipes(forCategory category: String)
    var selectedCategoryRecipes: [RecipeResult] { get }
    func indexesOfRecipes(forCategory category: String) -> [Int]
}

protocol RecipeListViewProtocol: AnyObject {
    func updateUI()
}

class RecipeListPresenter: RecipeListPresenterProtocol {
    
    weak var view: RecipeListViewProtocol?
    var recipes: [RecipeResult] = []
    var categories = [ "Burger", "Egg", "Meat", "Apple"]
    private let networkService: RecipeNetworkServiceProtocol
    
    init(networkService: RecipeNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func a(row: Int) -> String {
        categories[row]
    }
    var selectedCategoryRecipes: [RecipeResult] = []
    
    func fetchSelectedCategoryRecipes(forCategory category: String) {
        selectedCategoryRecipes = recipes.filter { $0.title.lowercased().contains(category.lowercased()) }
        view?.updateUI()
    }
    
    func indexesOfRecipes(forCategory category: String) -> [Int] {
        let filteredRecipes = recipes.filter { $0.title.lowercased().contains(category.lowercased()) }
        return filteredRecipes.compactMap { recipe in
            return recipes.firstIndex { $0.id == recipe.id }
        }
    }
    
    func fetchRecipes() {
        for category in categories {
            networkService.fetchRecipes(forCategory: category) { [weak self] result in
                switch result {
                case .success(let recipes):
                    self?.recipes += recipes
                    self?.view?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func numberOfCategories() -> Int {
        categories.count
    }
    
    func numberOfDishes() -> Int {
        recipes.count
    }
    
}
