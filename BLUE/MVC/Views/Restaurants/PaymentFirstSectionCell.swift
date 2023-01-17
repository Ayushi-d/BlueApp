//
//  PaymentFirstSectionCell.swift
//  BLUE
//
//  Created by Bhikhu on 08/10/22.
//

import UIKit

class PaymentFirstSectionCell: UITableViewCell,  NibReusable {

    @IBOutlet weak var lblProduct: AppBaseLabel!
    @IBOutlet weak var lblPrice: AppBaseLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig(with object: CartModel)  {
        lblProduct.text = object.name
        lblPrice.text = (object.total ?? "0.0") + " KWD"
    }

    func cellConfigwithPackage(with object: Packages)  {
        lblProduct.text = object.name
        lblPrice.text = (object.price ?? "0.0") +  " KWD"
    }
    
    func cellConfigSeafarer(with object: SeafarerData){
        lblProduct.text = object.name
        lblPrice.text = (object.amount ?? "0.0") + " KWD"
    }

    
}
