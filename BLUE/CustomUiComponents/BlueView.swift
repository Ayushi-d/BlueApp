//
//  BlueView.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 25/09/22.
//

import UIKit

class BlueView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.init(named: "BlueViewColor")
        self.layer.borderColor = UIColor.init(named: "ButtonColor")?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
            }

}
