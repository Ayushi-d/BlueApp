//
//  AccountCell.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 26/09/22.
//

import UIKit

protocol accountDelegate{
    func notificationSwitch(isON: Bool)
}

class AccountCell: UITableViewCell {
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var accountBtn: UIButton!
    @IBOutlet weak var accountImage: UIImageView!
    var delegate : accountDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func notificationSwitch(_ sender: UISwitch) {
        delegate?.notificationSwitch(isON: sender.isOn)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
