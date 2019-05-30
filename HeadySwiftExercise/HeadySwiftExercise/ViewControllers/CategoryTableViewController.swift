//
//  CategoryTableViewController.swift
//  HeadySwiftExercise
//
//  Created by Ankit Patel on 30/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    static let ALERT_TITLE = "No Categories Found"
    static let ALERT_NO_CATEGORIES = "There is no categories found at the moment"
    
    private var categories = [Category]()
    private var filteredCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.title = "Home"
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //fetch data from server
        self.fetchData()
    }
    
    private func fetchData(){
        //make a network call
        DataManager.shared.fetchCategories { (categories) in
            if let categories = categories {
                self.categories = categories
                self.filteredCategories = categories.filter{ (category) in
                    if category.child_categories.count > 0 {
                        return true
                    }
                    else{
                        return false
                    }
                }
            }
            else{
                self.showAlert()
            }
            self.tableView.reloadData()
        }
    }
    
    /**
     Show alert if data not available
     */
    private func showAlert() {
        let alert = UIAlertController(title: CategoryTableViewController.ALERT_TITLE, message: CategoryTableViewController.ALERT_NO_CATEGORIES,         preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.filteredCategories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.CELL_ID) as! CategoryCell
        cell.configureCell(category: self.filteredCategories[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

class CategoryCell: UITableViewCell{
    static let CELL_ID: String = "CategoryCell"
    @IBOutlet var lblCategory: UILabel!
    
    var category: Category!
    
    func configureCell(category:Category){
        self.category = category
        self.lblCategory.text = self.category.name
    }
    
}
