//
//  AccessoriesHeaderViewCell.swift
//  BLUE
//
//  Created by Bhikhu on 06/10/22.
//

import UIKit

class AccessoriesHeaderViewCell: UITableViewCell,NibReusable {

    @IBOutlet weak var viewVest: BlueView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewVest.backgroundColor = Color.Color.buttonColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
