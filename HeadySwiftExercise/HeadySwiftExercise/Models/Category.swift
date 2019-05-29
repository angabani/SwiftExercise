//
//  Category.swift
//  HeadySwiftExercise
//
//  Created by Ankit Patel on 29/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let products: [Product]
    let child_categories: [Int]
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Category.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}
