//
//  CategoryTableViewController.swift
//  HeadySwiftExercise
//
//  Created by Ankit Gabani on 30/05/19.
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
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "Home"
        //fetch data from server
        self.fetchData()
    }
    
    private func fetchData(){
        //make a network call
        DataManager.shared.fetchCategories { (categories) in
            if let categories = categories { //check if categories null or not
                self.categories = categories //assign it to main categories property
                //filter categories and show only parent categories
                self.filteredCategories = categories.filter{ (category) in
                    return category.child_categories.count > 0 ? true : false
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

class CategoryCell: UITableViewCell{
    static let CELL_ID: String = "CategoryCell"
    @IBOutlet var lblCategory: UILabel!
    
    var category: Category!
    
    func configureCell(category:Category){
        self.category = category
        self.lblCategory.text = self.category.name
    }
    
}
