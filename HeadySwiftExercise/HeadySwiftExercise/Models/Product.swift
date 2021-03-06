//
//  Product.swift
//  HeadySwiftExercise
//
//  Created by Ankit Gabani on 29/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let date_added: String
    let variants: [Variant]
    let tax: Tax
    var view_count: Int? //for sorting purpose
    var order_count: Int? //for sorting purpose
    var shares: Int? //for sorting purpose
    
    init(){
        id = 0
        name = ""
        date_added = ""
        variants = []
        tax = Tax()
        view_count = 0
        order_count = 0
        shares = 0
    }
    
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Product.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}
