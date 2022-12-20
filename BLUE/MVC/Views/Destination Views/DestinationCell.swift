//
//  DestinationCell.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 26/09/22.
//

import UIKit

class DestinationCell: UITableViewCell {

    @IBOutlet weak var viewBlue: BlueView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var bntTime: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cellConfig(with object: DestinationAddress)  {
        lblPrice.text = (object.price ?? "0") + Localizable.Currency.symbolKWD
        lblTitle.text = object.destinationAddress ?? ""
        bntTime.setTitle("Min " + String(object.destinationHrs ?? 0) +  " Hrs", for: .normal)
    }
    
}
