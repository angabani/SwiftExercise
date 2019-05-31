//
//  ProductListTableViewController.swift
//  HeadySwiftExercise
//
//  Created by Ankit Gabani on 30/05/19.
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
        
        //assign products with default sortings
        self.sortedProducts = self.selectedCategory.products
    }
    
    @IBAction func showSortingOptions(){
        let alert = UIAlertController(title: "Sort By", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Default", style: .default , handler:{ (UIAlertAction)in
            //reset sorting options
            self.sortedProducts = self.selectedCategory.products
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "View Count", style: .default , handler:{ (UIAlertAction)in
            //sort by views count
            self.sortedProducts = self.selectedCategory.products.sorted(by: { $0.view_count ?? 0 > $1.view_count ?? 0 })
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Order Count", style: .default , handler:{ (UIAlertAction)in
            //sort by order count
            self.sortedProducts = self.selectedCategory.products.sorted(by: { $0.order_count ?? 0 > $1.order_count ?? 0 })
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Share Count", style: .default, handler:{ (UIAlertAction)in
            //sort by share count
            self.sortedProducts = self.selectedCategory.products.sorted(by: { $0.shares ?? 0 > $1.shares ?? 0 })
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            //cancel
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
        return self.sortedProducts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.CELL_ID) as! ProductCell
        cell.configureCell(product: self.sortedProducts[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailViewController
        productDetailVC.selectedProduct = self.sortedProducts[indexPath.row]
        //push product details view
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
}

class ProductCell: UITableViewCell{
    static let CELL_ID: String = "ProductCell"
    @IBOutlet var lblProduct: UILabel!
    @IBOutlet var lblViewCount: UILabel!
    @IBOutlet var lblOrderCount: UILabel!
    @IBOutlet var lblShareCount: UILabel!
    var product: Product!
    
    func configureCell(product:Product){
        self.product = product
        self.lblProduct.text = self.product.name
        self.lblViewCount.text = "Views: \(self.product.view_count ?? 0)"
        self.lblOrderCount.text = "Orders: \(self.product.order_count ?? 0)"
        self.lblShareCount.text = "Shares: \(self.product.shares ?? 0)"
    }
    
}
