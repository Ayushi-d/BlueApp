//
//  PackageCell.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 27/09/22.
//

import UIKit

class PackageCell: UITableViewCell {

    @IBOutlet weak var packageLabel: UILabel!
    @IBOutlet weak var packageFeatures: UILabel!
    @IBOutlet weak var packagePrice: UILabel!
    @IBOutlet weak var addButton: BlueButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
    }
    
    func cellConfig(with object: Packages) {
        packageLabel.text = object.name ?? ""
        packageFeatures.text = object.features ?? ""
        packagePrice.text = object.price ?? "" + Localizable.Currency.symbolKWD
        addButton.isUserInteractionEnabled = false
        if object.isAdded == false{
            addButton.backgroundColor = UIColor.Color.buttonColor
            addButton.setTitle( "Add", for: .normal)
            addButton.borderWidth  = 0
        } else {
            addButton.backgroundColor = UIColor.clear
            addButton.setTitle( "Added", for: .normal)
            addButton.borderWidth = 1
            addButton.borderColor = UIColor.Color.buttonColor
        }
    }
}
