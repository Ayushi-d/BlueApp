//
//  AllBoatsTableCell.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 25/09/22.
//

import UIKit

protocol AllBoatsDelegate {
    func viewOnMapTapped(tag: Int)
    func parkNowTapped(tag: Int)
}

class AllBoatsTableCell: UITableViewCell {
    
    @IBOutlet weak var boatimage: UIImageView!
    @IBOutlet weak var boatLocation: UIButton!
    @IBOutlet weak var boatName: UILabel!
    @IBOutlet weak var boatprice: UILabel!
    @IBOutlet weak var parkedButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var ratingLabel: UIButton!
    var delegate: AllBoatsDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig(with object: BoatListDataModel) {
        boatName.text = object.name ?? ""
        boatLocation.setTitle(object.pickupAddress ?? "", for: .normal)
        boatprice.text = "Starting from " + (object.startingFrom ?? "") + " " + "KWD"
        boatimage.setImage(withURL: object.featuredImage ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
        //boatimage.setImageUsingKF(string: object.featuredImage ?? "", placeholder: PlaceHolderImages.homelaceHolder,isFited: false)
    }
    
    func cellConfigParking(with data: AvailableParking){
        boatName.text = data.name ?? ""
        boatimage.setImageUsingKF(string: data.image ?? "", placeholder: PlaceHolderImages.homelaceHolder,isFited: false)
        boatprice.text = "Starting from " + (data.price ?? "") + " " + "KWD"
        if data.parkingStatus != "parked"{
            mapButton.setTitle("Not Parked", for: .normal)
            parkedButton.setTitle("Park Now", for: .normal)
            //parkedButton.setTitleColor(UIColor.lightGray, for: .normal)
        }
    }
    
    @IBAction func mapButtonTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "View on Map"{
            delegate?.viewOnMapTapped(tag: sender.tag)
        }
    }
    
    @IBAction func parkedButtonTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "Park Now"{
            delegate?.parkNowTapped(tag: sender.tag)
        }
    }
    
}
