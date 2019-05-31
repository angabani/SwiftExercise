//
//  DataManager.swift
//  HeadySwiftExercise
//
//  Created by Ankit Gabani on 30/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation

class DataManager{
    static let shared = DataManager()
    static let CATEGORIES_URL = "http://stark-spire-93433.herokuapp.com/json"
    
    //do not allow to initialize its object
    private init(){}

    //fetch categories from web service and manage data
    func fetchCategories(completion: @escaping ([Category]?) -> Void) {
        
        //get call
        NetworkManager.shared.getData(url: DataManager.CATEGORIES_URL) { (data) in
            
            //received data and check if categories and ranking there in the response
            guard let value = data,
               let data = value["categories"] as? [[String: Any]],
               let rankings = value["rankings"]as? [[String: Any]] else {
                   print("Malformed data received from fetchCategories service")
                   completion(nil)
                   return
                
            }
            
            do {

                //parse categories from the data
                var categories = try data.compactMap { catDict in
                    return try Category(dictionary: catDict)
                }
                
                //define ranking dictionaries for sorting purpose
                var viewCountDict = [Int:Int]()
                var orderCountDict = [Int:Int]()
                var shareCountDict = [Int:Int]()
                
                //iterate rankings to prepare ranking dictionary
                for rank in rankings{
                    switch (rank["ranking"] as? String){
                    case "Most Viewed Products":
                        guard let products = rank["products"] as? [[String: Int]] else {
                            continue
                        }
                        //prepare view count ranking dictionary
                        viewCountDict = products.reduce([Int: Int]()) { (dict, product) -> [Int: Int] in
                            var dict = dict
                            dict[product["id"] ?? 0] = product["view_count"] ?? 0
                            return dict
                        }
                    case "Most OrdeRed Products":
                        guard let products = rank["products"] as? [[String: Int]] else {
                            continue
                        }
                        //prepare order count ranking dictionary
                        orderCountDict = products.reduce([Int: Int]()) { (dict, product) -> [Int: Int] in
                            var dict = dict
                            dict[product["id"] ?? 0] = product["order_count"] ?? 0
                            return dict
                        }
                    case "Most ShaRed Products":
                        guard let products = rank["products"] as? [[String: Int]] else {
                            continue
                        }
                        //prepare share count ranking dictionary
                        shareCountDict = products.reduce([Int: Int]()) { (dict, product) -> [Int: Int] in
                            var dict = dict
                            dict[product["id"] ?? 0] = product["shares"] ?? 0
                            return dict
                        }
                    default:
                        print("Default")
                    }
                }
                
                //iterate categories and products to assign values of views, orders, shares for specific product using product id
                for catIndex in 0..<categories.count {
                    for productIndex in 0..<categories[catIndex].products.count {
                        //assign view count value for specific product with id
                        categories[catIndex].products[productIndex].view_count = viewCountDict[categories[catIndex].products[productIndex].id]
                        //assign order count value for specific product with id
                        categories[catIndex].products[productIndex].order_count = orderCountDict[categories[catIndex].products[productIndex].id]
                        //assign share count value for specific product with id
                        categories[catIndex].products[productIndex].shares = shareCountDict[categories[catIndex].products[productIndex].id]
                    }
                }
                //return prepared category data to view controller
                completion(categories)
            }
            catch {
                // Error handling
                print(error)
                completion(nil)
            }
        }
    }
}
