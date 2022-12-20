//
//  BlueButton.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 22/09/22.
//

import UIKit

class BlueButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.init(named: "ButtonColor")
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont.SourceSansProSemiBold(size: FontSize.navigationTitle.rawValue)
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
