//
//  Category.swift
//  HeadySwiftExercise
//
//  Created by Ankit Gabani on 29/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    var products: [Product]
    let child_categories: [Int]
    
    init(){
        id = 0
        name = ""
        products = [Product]()
        child_categories = []
    }
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Category.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}
