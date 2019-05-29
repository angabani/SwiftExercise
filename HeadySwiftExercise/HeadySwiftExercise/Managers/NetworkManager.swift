//
//  NetworkManager.swift
//  HeadySwiftExercise
//
//  Created by Ankit Patel on 29/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    static let shared = NetworkManager()
    static let CATEGORIES_URL = "http://stark-spire-93433.herokuapp.com/json"
    
    //do not allow to initialize its object
    private init(){}
    
    // With Alamofire get list of categories
    func fetchCategories(completion: @escaping ([Category]?) -> Void) {
        
        //check for internet connection if not available show data from local
        if !Connectivity.isConnectedToInternet(){
            //get data from local
            guard let data = AGUtil.getCategoriesFromUD() else{
                completion(nil)
                return
            }
            do {
                let categories = try data.compactMap { catDict in
                    return try Category(dictionary: catDict) }
                completion(categories)
            }
            catch _ {
                // Error handling
                completion(nil)
            }
        }
        else{
            //get data from api
            guard let url = URL(string: NetworkManager.CATEGORIES_URL) else {
                completion(nil)
                return
            }
            Alamofire.request(url)
                .validate()
                .responseJSON { response in
                    guard response.result.isSuccess else {
                        //                    print("Error while fetching categories: \(String(describing: response.result.error)")
                        completion(nil)
                        return
                    }
                    
                    guard let value = response.result.value as? [String: Any],
                        let data = value["categories"] as? [[String: Any]],
                        let rankings = value["rankings"]as? [[String: Any]] else {
                            print("Malformed data received from fetchCategories service")
                            completion(nil)
                            return
                    }
                    //store data in local
//                    AGUtil.saveCategoriesToUD(data: data)
                    
                    do {
                        
//                        let result = zip(data, data).enumerated().filter() {
//                            $1.0 == $1.1
//                            }.map{$0.0}
                        
                        let categories = try data.compactMap { catDict in
                            return try Category(dictionary: catDict)
                        }
//                        let rankingList = try rankings.compactMap { rankDict in
//                            return try Rank(dictionary: rankDict)
//                        }
                        print(rankings)
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
}

