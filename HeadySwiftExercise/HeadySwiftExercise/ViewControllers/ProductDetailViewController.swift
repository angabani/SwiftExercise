//
//  ProductDetailViewController.swift
//  HeadySwiftExercise
//
//  Created by Ankit Gabani on 30/05/19.
//  Copyright © 2019 Ankit Gabani. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var selectedProduct = Product()
    
    @IBOutlet var lblName: UILabel!
    //collection view for variants
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var lblTax: UILabel!
    @IBOutlet var lblCreatedDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = self.selectedProduct.name
        
        //show product name
        self.lblName.text = self.selectedProduct.name
        
        //show tax details
        self.lblTax.text = "\(self.selectedProduct.tax.name): \(self.selectedProduct.tax.value)%"
        
        //show date added for product
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:self.selectedProduct.date_added)!
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        self.lblCreatedDate.text = "Date Added: \(dateFormatter.string(from: date))"
    }
    
    // MARK: - UICollectionViewDataSource
    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.selectedProduct.variants.count
    }
    
    //3
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: VariantCell.CELL_ID, for: indexPath) as! VariantCell
        
        // Configure cell to show variant details
        cell.configureCell(variant: self.selectedProduct.variants[indexPath.row])
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class VariantCell: UICollectionViewCell{
    static let CELL_ID: String = "VariantCell"
    @IBOutlet var lblColor: UILabel!
    @IBOutlet var lblSize: UILabel!
    @IBOutlet var lblPrice: UILabel!
    var variant: Variant!
    
    func configureCell(variant:Variant){
        self.variant = variant
        self.lblColor.text = "Color: \(variant.color)"
        self.lblSize.text = (variant.size != nil) ? "Size: \(variant.size ?? 0) " : ""
        self.lblPrice.text = "Price: \(variant.price)"
    }
    
}
