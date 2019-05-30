//
//  Tax.swift
//  HeadySwiftExercise
//
//  Created by Ankit Patel on 29/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation

struct Tax: Codable {
    let name: String
    let value: Double
    
    init(){
        name = ""
        value = 0
    }
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Tax.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}
