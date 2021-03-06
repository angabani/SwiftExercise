//
//  SubCategoryTableViewController.swift
//  HeadySwiftExercise
//
//  Created by Ankit Gabani on 30/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import UIKit

class SubCategoryTableViewController: UITableViewController {

    var categories = [Category]() //for default list if user select default sorting
    var filteredCategories = [Category]() //for assigning child category values based on sorting options
    var selectedCategory = Category() //for identifying parent category
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = self.selectedCategory.name
        
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
        //check if selected category has child categories, if yes - show sub category else show prodoct list
        if self.filteredCategories[indexPath.row].child_categories.count > 0 {
        
            let subCatTVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubCategoryTVC") as! SubCategoryTableViewController
            subCatTVC.selectedCategory = self.filteredCategories[indexPath.row]
            subCatTVC.categories = self.categories
            subCatTVC.filteredCategories = self.categories.filter{ (category) in
                return self.filteredCategories[indexPath.row].child_categories.contains(category.id) ? true : false
            }
            //push to sub category view
            self.navigationController?.pushViewController(subCatTVC, animated: true)
        }
        else{
            let productListTVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductListTVC") as! ProductListTableViewController
            productListTVC.selectedCategory = self.filteredCategories[indexPath.row]
            //push to product list view
            self.navigationController?.pushViewController(productListTVC, animated: true)
        }
    }
    
}
