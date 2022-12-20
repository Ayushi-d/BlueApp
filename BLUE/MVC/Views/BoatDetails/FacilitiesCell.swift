//
//  FacilitiesCell.swift
//  BLUE
//
//  Created by Bhikhu on 22/10/22.
//

import UIKit

class FacilitiesCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var img: UIImageView!
    
    func cellConfig(with object: Facilities ){
        switch object.name {
        case facilitiesEnum.Wifi.rawValue:
            img.image = facilitiesEnum.Wifi.getImag()
        case facilitiesEnum.Food.rawValue:
            img.image = facilitiesEnum.Food.getImag()
        case facilitiesEnum.Restaurants.rawValue:
            img.image = facilitiesEnum.Restaurants.getImag()
        case facilitiesEnum.Television.rawValue:
            img.image = facilitiesEnum.Television.getImag()
        default:
            break
        }
    }

}
