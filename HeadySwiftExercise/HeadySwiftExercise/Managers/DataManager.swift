//
//  DataManager.swift
//  HeadySwiftExercise
//
//  Created by Ankit Patel on 30/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation

class DataManager{
    static let shared = DataManager()
    static let CATEGORIES_URL = "http://stark-spire-93433.herokuapp.com/json"
    
    //do not allow to initialize its object
    private init(){}

    func fetchCategories(completion: @escaping ([Category]?) -> Void) {
        
        NetworkManager.shared.getData(url: DataManager.CATEGORIES_URL) { (data) in
            
            
            guard let value = data,
               let data = value["categories"] as? [[String: Any]],
               let rankings = value["rankings"]as? [[String: Any]] else {
                   print("Malformed data received from fetchCategories service")
                   completion(nil)
                   return
                
            }
            
            //store data in local
            AGUtil.saveCategoriesToUD(data: value)
            
            do {

                var categories = try data.compactMap { catDict in
                    return try Category(dictionary: catDict)
                }

                print(rankings)
                
                for rank in rankings{
                    switch (rank["ranking"] as? String){
                    case "Most Viewed Products":
                        guard let products = rank["products"] as? [[String: Any]] else {
                            continue
                        }
                        for product in products{
                            for catIndex in 0..<categories.count {
//                            for category in categories{
                                for productIndex in 0..<categories[catIndex].products.count {
                                //for catProduct in category.products{
                                    if product["id"] as? Int == categories[catIndex].products[productIndex].id{
                                        categories[catIndex].products[productIndex].view_count = product["view_count"] as? Int ?? 0
//                                        print("view_count \(categories[catIndex].products[productIndex].view_count ?? 0)")
                                    }
                                }
                                
                            }
                        }
                    case "Most OrdeRed Products":
                        print("OrdeRed")
                        guard let products = rank["products"] as? [[String: Any]] else {
                            continue
                        }
                        for product in products{
                            for catIndex in 0..<categories.count {
                                //                            for category in categories{
                                for productIndex in 0..<categories[catIndex].products.count {
                                    //for catProduct in category.products{
                                    if product["id"] as? Int == categories[catIndex].products[productIndex].id{
                                        categories[catIndex].products[productIndex].order_count = product["order_count"] as? Int ?? 0
//                                        print("order_count \(categories[catIndex].products[productIndex].order_count ?? 0)")
                                    }
                                }
                                
                            }
                        }
                    case "Most ShaRed Products":
                        print("ShaRed")
                        guard let products = rank["products"] as? [[String: Any]] else {
                            continue
                        }
                        for product in products{
                            for catIndex in 0..<categories.count {
                                //                            for category in categories{
                                for productIndex in 0..<categories[catIndex].products.count {
                                    //for catProduct in category.products{
                                    if product["id"] as? Int == categories[catIndex].products[productIndex].id{
                                        categories[catIndex].products[productIndex].shares = product["shares"] as? Int ?? 0
//                                        print("shares \(categories[catIndex].products[productIndex].shares ?? 0)")
                                    }
                                }
                                
                            }
                        }
                    default:
                        print("Default")
                    }
                }
  
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
