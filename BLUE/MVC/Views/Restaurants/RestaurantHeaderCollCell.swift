//
//  RestaurantHeaderCollCell.swift
//  BLUE
//
//  Created by MacBook M1 on 18/11/22.
//

import UIKit

class RestaurantHeaderCollCell: UICollectionViewCell {

    @IBOutlet weak var itemCategoryName: AppBaseLabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    
    func configcell(with object: ProductCategory){
        self.itemCategoryName.text = object.name
        self.itemImage.setImageUsingKF(string: object.image ?? "", placeholder: nil)
        
    }

}
