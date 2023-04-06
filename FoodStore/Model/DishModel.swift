//
//  DishModel.swift
//  FoodStore
//
//  Created by Артем Орлов on 04.04.2023.
//

import Foundation

struct RecipeSearchResponse: Decodable {
    let results: [RecipeResult]
}

struct RecipeResult: Decodable {
    let id: Int
    let title: String
    let image: String
}
