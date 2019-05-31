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
    
    //do not allow to initialize its object
    private init(){}
    
    // With Alamofire get list of categories
    func getData(url:String, completion: @escaping ([String: Any]?) -> Void) {
        
        //check for internet connection if not available show data from local
        if !Connectivity.isConnectedToInternet(){
            //get data from local
            guard let data = AGUtil.getCategoriesFromUD() else{
                completion(nil)
                return
            }
            completion(data)
        }
        else{
            //get data from api
            guard let url = URL(string: url) else {
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
                    
                    guard let data = response.result.value as? [String: Any] else {
                        completion(nil)
                        return
                    }
                    //store data in local
                    AGUtil.saveCategoriesToUD(data: data)
                    completion(data)
            }
        }
    }
}

