//
//  HomeCell.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 26/09/22.
//

import UIKit

class HomeCell: UITableViewCell {
    
    
    @IBOutlet weak var viewLayer: UIView!
    @IBOutlet weak var boatLabel: UILabel!
    @IBOutlet weak var boatImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfig(with object: Category ) {
        boatLabel.text = object.name ?? ""
//        boatImage.setImageUsingKF(string: object.image, placeholder: PlaceHolderImages.homelaceHolder,isFited: false)

    }
    
}
