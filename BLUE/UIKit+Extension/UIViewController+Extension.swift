//
//  UIViewController+Extension.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 25/09/22.
//

import Foundation
import UIKit
import Hero
import Lightbox

extension UIViewController {
    
    func poptoViewController(){
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoomOut
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        poptoViewController()
    }
    func pushVC(controller: UIViewController)  {
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(controller, animated: true)

    }
    func showCamaeraNotAvailable() {
        //            AlertMesage.show(.error, message: "Camera is not supported in this device.")
        UIAlertController.showAlertWithOkButton(controller: self, message: "Camera is not supported in this device.", completion: nil)
    }
}

