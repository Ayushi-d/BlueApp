//
//  DestinationVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 26/09/22.
//

import UIKit
import SwiftUI

class DestinationVC: UIViewController , StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)
    var arrDestinationAddress: [DestinationAddress]?
    @IBOutlet weak var destinationTableView: UITableView!{
        didSet{
            destinationTableView.register(UINib(nibName: "DestinationCell", bundle: nil), forCellReuseIdentifier: "DestinationCell")
        }
    }
    @IBOutlet weak var noDestinationlabel: AppBaseLabel!
    var completionblock: ((DestinationAddress?) -> Void)?
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noDestinationlabel.isHidden = arrDestinationAddress?.count ?? 0 > 0 ? true : false
    }
    
    @IBAction func selectDestinationTapped(_ sender: Any) {
        if arrDestinationAddress?.count ?? 0 > selectedIndex ,   selectedIndex != -1 {
            if let object = arrDestinationAddress?[selectedIndex] {
                completionblock?(object)
                self.poptoViewController()
            }
        }
    }
}

extension DestinationVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDestinationAddress?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = destinationTableView.dequeueReusableCell(withIdentifier: "DestinationCell", for: indexPath) as? DestinationCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        if let object = arrDestinationAddress?[indexPath.row] {
            cell.cellConfig(with: object)
        }
        if indexPath.row == selectedIndex {
            cell.viewBlue.backgroundColor =  UIColor.Color.buttonColor
        } else {
            cell.viewBlue.backgroundColor =  UIColor.Color.blueViewColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        destinationTableView.reloadData()
    }
}
