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

    @IBOutlet weak var blurParentView: UIView!
    @IBOutlet weak var blurView: UIView!
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
        if !(object.isUnlocked ?? false){
            self.blurView.removeBlurEffect()
            self.blurView.backgroundColor = .clear
            self.blurView.blurView(with: 1.8)
            self.blurParentView.isHidden = false
        }else{
            self.blurView.removeBlurEffect()
            self.blurParentView.isHidden = true
        }
        seaFarerlanguages.text = "Spoken languages: \(object.language?.joined(separator: ",") ?? "")"
        seaFarerName.text = object.name
        seaFarerNationality.text = "Nationality: \(object.nationality ?? "")"
        seaFarerBoatExperince.text = "Boat experience: \(object.baot_experince?.joined(separator: ",") ?? "")"
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
