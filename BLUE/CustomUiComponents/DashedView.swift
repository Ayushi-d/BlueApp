//
//  DashedView.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 25/09/22.
//

import UIKit

class DashedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4,4]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width-20, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
  
}
