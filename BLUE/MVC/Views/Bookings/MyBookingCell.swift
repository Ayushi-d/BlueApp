//
//  MyBookingCell.swift
//  BLUE
//
//  Created by Bhikhu on 15/10/22.
//

import UIKit

class MyBookingCell: UITableViewCell, NibReusable {

    @IBOutlet weak var lblPrice: AppBaseLabel!
    @IBOutlet weak var lblBookingID: AppBaseLabel!
    @IBOutlet weak var lblTitle: AppBaseLabel!
    @IBOutlet weak var bookedlabel: AppBaseLabel!
    @IBOutlet weak var bookedImage: UIImageView!
    @IBOutlet weak var boatImage: UIImageView!
    @IBOutlet weak var bookWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(with object: MyBoatsBookingModel)  {
        lblPrice.text = "Price: " + (object.grand_total ?? "")
        lblBookingID.text = "Booking Id: " + "\(object.id ?? 0)"
        bookedlabel.text = object.status
        lblTitle.text = object.name
        boatImage.setImage(withURL: object.image ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
    }
    
    func configCellForMyBoat(with object: MyBoatData)  {
        self.bookedImage.isHidden = true
        lblPrice.text = "Type: "+(object.boat_type ?? "")
        lblBookingID.text = "Height: "+(object.height ?? "")
        bookedlabel.text = "Width: "+(object.width ?? "")
        lblTitle.text = object.name
        boatImage.setImage(withURL: object.image?[0] ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
    
    }
    
}
