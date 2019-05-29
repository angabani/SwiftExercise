//
//  AGUtil.swift
//  HeadySwiftExercise
//
//  Created by Ankit Patel on 29/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation
import Alamofire

class AGUtil{
    static let CATEGORY_USER_DEFAULT_KEY = "Categories"
    
    //save data to user defaults
    class func saveCategoriesToUD(data:[[String: Any]]){
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: AGUtil.CATEGORY_USER_DEFAULT_KEY)
    }
    
    //get data from user defaults
    class func getCategoriesFromUD() -> [[String: Any]]?{
        let defaults = UserDefaults.standard
        guard let categories = defaults.array(forKey: AGUtil.CATEGORY_USER_DEFAULT_KEY) as? [[String : Any]] else {
            return nil
        }
        return categories
    }
    
}

class Connectivity {
    //check for internet connection
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
