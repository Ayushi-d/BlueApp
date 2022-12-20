//
//  PaymentCell.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 25/09/22.
//

import UIKit

class PaymentCell: UITableViewCell, NibReusable {

    @IBOutlet weak var radioImage: UIImageView!
    @IBOutlet weak var paymentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
