//
//  RestaurantCell.swift
//  BLUE
//
//  Created by Bhikhu on 05/10/22.
//

import UIKit

class RestaurantCell: UITableViewCell, NibReusable {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblDescription: AppBaseLabel!
    @IBOutlet weak var lblTitle: AppBaseLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfig(with object: ProductSubCategory)  {
        lblDescription.text = object.createdAt
        lblTitle.text = object.name
        //img.setImageUsingKF(string: object.image ?? "", placeholder: PlaceHolderImages.homelaceHolder,isFited: false)
        img.setImage(withURL: object.image ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
    }
    
}
