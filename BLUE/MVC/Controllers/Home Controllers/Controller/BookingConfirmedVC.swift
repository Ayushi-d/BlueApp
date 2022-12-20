//
//  BookingConfirmedVC.swift
//  BLUE
//
//  Created by Bhikhu on 13/10/22.
//

import UIKit

class BookingConfirmedVC: UIViewController, StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: IB Actions
    @IBAction func btnRateUsTapped(_ sender: Any) {
        self.pushVC(controller: BottomBarController.instantiate())
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        self.poptoViewController()
    }
}
