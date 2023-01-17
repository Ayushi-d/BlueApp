//
//  UIView+Extensions.swift
//  BLUE
//
//

import Foundation
import UIKit


extension UIView{
    
    func blurView(with intensity: Double) {
        let blurEffectView = TSBlurEffectView() // creating a blur effect view
        blurEffectView.intensity = intensity // setting blur intensity from 0.1 to 10
        self.addSubview(blurEffectView)
    }
    
      func removeBlurEffect() {
          for subview in self.subviews {
              if subview is UIVisualEffectView {
                  subview.removeFromSuperview()
              }
          }
      }
}
