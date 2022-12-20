//
//  BookingDoneVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 25/09/22.
//

import UIKit
import Hero

class BookingDoneVC: UIViewController {

    @IBOutlet weak var parkingDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
    @IBAction func notificationTapped(_ sender: Any) {
        
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: StoryBoard.bottomBarStoryBoard, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "BottomBarController") as! BottomBarController
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
