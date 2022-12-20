//
//  GreyView.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 25/09/22.
//

import UIKit

class GreyView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        self.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
            }

}
