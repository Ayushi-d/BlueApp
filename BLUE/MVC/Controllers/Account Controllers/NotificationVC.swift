//
//  NotificationVC.swift
//  BLUE
//
//

import UIKit

class NotificationVC: UIViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.account.rawValue, bundle: nil)


    @IBOutlet weak var notifiationTable: UITableView!
    
    @IBOutlet weak var noNotificationLabel: AppBaseLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
}
