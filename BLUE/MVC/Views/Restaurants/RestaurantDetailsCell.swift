//
//  RestaurantDetailsCell.swift
//  BLUE
//
//  Created by Bhikhu on 06/10/22.
//

import UIKit

class RestaurantDetailsCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lblPrice: AppBaseLabel!
    @IBOutlet weak var lblDescription: AppBaseLabel!
    @IBOutlet weak var lblTitle: AppBaseLabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfig(with object: ProductList)   {
        lblPrice.text = (object.price ?? "0.0")+"KWD"
        lblTitle.text = object.name
        lblDescription.text = object.description
        img.setImage(withURL: object.image ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
        //img.setImageUsingKF(string: object.image ?? "", placeholder: PlaceHolderImages.homelaceHolder,isFited: false)
    }
    
}
