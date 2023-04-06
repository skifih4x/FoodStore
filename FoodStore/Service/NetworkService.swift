//
//  NetworkService.swift
//  FoodStore
//
//  Created by Артем Орлов on 03.04.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

protocol RecipeNetworkServiceProtocol {
    func fetchRecipes(forCategory category: String, completion: @escaping (Result<[RecipeResult], Error>) -> Void)
}

class RecipeNetworkService: RecipeNetworkServiceProtocol {
    
    func fetchRecipes(forCategory category: String, completion: @escaping (Result<[RecipeResult], Error>) -> Void) {
        guard let url = makeURL(forCategory: category) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(RecipeSearchResponse.self, from: data)
                let recipes = response.results.map { result in
                    return RecipeResult(id: result.id, title: result.title, image: result.image)
                }
                completion(.success(recipes))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func makeURL(forCategory category: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = "/recipes/complexSearch"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: "37f723dc553444e88435a44768859ae4"),
            URLQueryItem(name: "query", value: category)
        ]
        return components.url
    }
}
