//
//  RestaurantHeadeViewCell.swift
//  BLUE
//
//  Created by Bhikhu on 06/10/22.
//

import UIKit

class RestaurantHeadeViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var viewFood: BlueView!
    @IBOutlet weak var collectionFoodView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewFood.backgroundColor = Color.Color.buttonColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
