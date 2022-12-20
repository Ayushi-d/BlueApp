//
//  SeaFarerCell.swift
//  BLUE
//
//

import UIKit

protocol SeaFarerPhoneProtocol{
    
    func didtappedPhone(tag: Int)
    
    func didtappedMessage(tag: Int)
}

class SeaFarerCell: UITableViewCell {

    @IBOutlet weak var seaFarerName: UILabel!
    @IBOutlet weak var seaFarerExperince: UILabel!
    @IBOutlet weak var seaFarerNationality: UILabel!
    @IBOutlet weak var seaFarerBoatExperince: UILabel!
    @IBOutlet weak var seaFarerAge: UILabel!
    @IBOutlet weak var seaFarerlanguages: UILabel!
    @IBOutlet weak var seaFarerPhone: UIButton!
    @IBOutlet weak var seaFarerMessage: UIButton!

    var delegate : SeaFarerPhoneProtocol?
    var seafarerata: SeafarerData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig(with object: SeafarerData ) {
        seaFarerlanguages.text = "Spoken languages: \(object.language ?? "")"
        seaFarerName.text = object.name
        seaFarerNationality.text = "Nationality: \(object.nationality ?? "")"
        seaFarerBoatExperince.text = "Boat experience: \(object.baot_experince ?? "")"
        seaFarerExperince.text = "Experience: \(object.experince ?? "")"
        seaFarerAge.text = "\(object.age ?? 35) years"
    }

    
    @IBAction func seaFarerCallTapped(_ sender: UIButton) {
        self.delegate?.didtappedPhone(tag: sender.tag)
    }
    
    @IBAction func seaFarerMsgTapped(_ sender: UIButton) {
        self.delegate?.didtappedMessage(tag: sender.tag)
    }
    
}
