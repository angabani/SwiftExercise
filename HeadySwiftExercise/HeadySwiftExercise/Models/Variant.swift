//
//  Variant.swift
//  HeadySwiftExercise
//
//  Created by Ankit Gabani on 29/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation

struct Variant: Codable {
    let id: Int
    let price: Double
    let color: String
    let size: Int?
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Variant.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}
