//
//  ParkingCell.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 26/09/22.
//

import UIKit

class ParkingCell: UITableViewCell {

    @IBOutlet weak var parkingBoatImage: UIImageView!
    @IBOutlet weak var parkingBoatName: UILabel!
    @IBOutlet weak var parkingBoatBookingID: UILabel!
    @IBOutlet weak var parkingBoatBookStatus: UIButton!
    @IBOutlet weak var parkingBoatPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with object: MyParkingModel){
        self.parkingBoatBookingID.text = "Booking id:\(object.id ?? 0)"
        self.parkingBoatBookStatus.setTitle("Parked", for: .normal)
        self.parkingBoatName.text = object.parking_name
        self.parkingBoatPrice.text = "\(object.grand_total ?? "0.0") KWD"
        parkingBoatImage.setImage(withURL: object.image ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
       // self.parkingBoatImage.setImageUsingKF(string: object.image, placeholder: PlaceHolderImages.homelaceHolder,isFited: false)
    }
    
}
