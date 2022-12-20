//
//  CartCell.swift
//  BLUE
//
//  Created by Bhikhu on 08/10/22.
//

import UIKit

protocol CartDelegate{
    
    func plusTapped(tag: Int)
    func minusTapped(tag: Int)
    func deleteTapped(tag: Int)
}

class CartCell: UITableViewCell,  NibReusable {

    @IBOutlet weak var lblQty: AppBaseLabel!
    @IBOutlet weak var lblPrice: AppBaseLabel!
    @IBOutlet weak var lblTime: AppBaseLabel!
    @IBOutlet weak var lblTitle: AppBaseLabel!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var plusButton:UIButton!
    @IBOutlet weak var minusButton:UIButton!
    @IBOutlet weak var deleteButton:UIButton!

    var delegate: CartDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig(with object: CartModel)  {
        lblTitle.text = object.name
        lblPrice.text = object.total
        lblQty.text = "\(object.qty ?? 1)"
        imgview.setImage(withURL: object.image ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
        //imgview.setImageUsingKF(string: object.image ?? "", placeholder: PlaceHolderImages.homelaceHolder,isFited: false)
    }
        
    @IBAction func minustapped(_ sender: UIButton) {
        if Int(lblQty.text!) ?? 0 > 1{
            delegate?.minusTapped(tag: sender.tag)
            //lblQty.text = "\((Int(lblQty.text!) ?? 0) - 1)"
        }
    }
    
    @IBAction func plusTapped(_ sender: UIButton) {
        delegate?.plusTapped(tag: sender.tag)
        //lblQty.text = "\((Int(lblQty.text!) ?? 0) + 1)"
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        delegate?.deleteTapped(tag: sender.tag)
        //lblQty.text = "\((Int(lblQty.text!) ?? 0) + 1)"
    }
}
