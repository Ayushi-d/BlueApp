//
//  ReviewCell.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 27/09/22.
//

import UIKit

class ReviewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var rating: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func cellConfig(object: CustomerReviewData){
        review.text = object.review
        username.text = object.username
        rating.setTitle(object.rating, for: .normal)
    }
}
