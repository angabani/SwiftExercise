//
//  ViewController.swift
//  HeadySwiftExercise
//
//  Created by Ankit Patel on 29/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.fetchData()
    }
    
    private func fetchData(){
        //make a network call
        NetworkManager.shared.fetchCategories { (categories) in
            
        }
    }


}

