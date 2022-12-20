//
//  GallryCell.swift
//  BLUE
//
//  Created by Bhikhu on 22/10/22.
//

import UIKit

class GallryCell: UICollectionViewCell , NibReusable{

    @IBOutlet weak var imgGallary: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func cellConfig(with object: BoatGallaryDataModel) {
        imgGallary.setImage(withURL: object.image ?? "", toShowIndicator: true,placeholderImage: PlaceHolderImages.homelaceHolder)
    }

}
