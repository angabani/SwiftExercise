//
//  AGUtil.swift
//  HeadySwiftExercise
//
//  Created by Ankit Gabani on 29/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import Foundation
import Alamofire

class AGUtil{
    static let CATEGORY_USER_DEFAULT_KEY = "Categories"
    
    //save data to user defaults
    class func saveCategoriesToUD(data:[String: Any]){
        //serialize json to data for storing in user defaults
        if let data = try? JSONSerialization.data(withJSONObject: data, options: []){
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: AGUtil.CATEGORY_USER_DEFAULT_KEY)
            defaults.synchronize()
        }else{
            print("data invalid")
        }
    }
    
    //get data from user defaults
    class func getCategoriesFromUD() -> [String: Any]?{
        let defaults = UserDefaults.standard
        guard let data = defaults.value(forKey: AGUtil.CATEGORY_USER_DEFAULT_KEY) as? Data else {
            return nil
        }
        //convert data into jsonobject
        guard let categories = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{
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
