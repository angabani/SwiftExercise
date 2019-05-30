//
//  ProductListTableViewController.swift
//  HeadySwiftExercise
//
//  Created by Ankit Patel on 30/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import UIKit

class ProductListTableViewController: UITableViewController {

    private var sortedProducts = [Product]()
    var selectedCategory = Category()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = self.selectedCategory.name
        
        self.sortedProducts = self.selectedCategory.products
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sortedProducts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.CELL_ID) as! ProductCell
        cell.configureCell(product: self.sortedProducts[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

class ProductCell: UITableViewCell{
    static let CELL_ID: String = "ProductCell"
    @IBOutlet var lblProduct: UILabel!
    
    var product: Product!
    
    func configureCell(product:Product){
        self.product = product
        self.lblProduct.text = self.product.name
    }
    
}
