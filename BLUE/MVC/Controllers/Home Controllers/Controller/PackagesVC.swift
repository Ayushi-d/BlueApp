//
//  PackagesVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 27/09/22.
//

import UIKit
import Hero
import SwiftUI

class PackagesVC: UIViewController, StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)

    @IBOutlet weak var noPackageLabel: AppBaseLabel!
    @IBOutlet weak var packageTableView: UITableView!{
            didSet{
                packageTableView.register(UINib(nibName: "PackageCell", bundle: nil), forCellReuseIdentifier: "PackageCell")
        }
    }
    var objBoatDetailsData: BoatDetailsData?
    var packages: Packages?
    var selectedIndex : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.noPackageLabel.isHidden = self.objBoatDetailsData?.packages?.count ?? 0 > 0 ? true : false
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        // navigateToRestaurantContainer()
        let vc = RestaurantsContainerVC.instantiate()
        vc.packageArr = packages
        vc.objBoatDetailsData = self.objBoatDetailsData
        self.pushVC(controller: vc)
    }
    
    @IBAction func notificationTapped(_ sender: Any) {
        self.pushVC(controller: NotificationVC.instantiate())
    }
    
}

extension PackagesVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objBoatDetailsData?.packages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = packageTableView.dequeueReusableCell(withIdentifier: "PackageCell", for: indexPath) as? PackageCell else {return UITableViewCell() }
        cell.selectionStyle = .none
        if let object = objBoatDetailsData?.packages?[indexPath.row] {
            if self.selectedIndex == indexPath.row{
                object.isAdded = true
            }else{
                object.isAdded = false
            }
            cell.cellConfig(with: object)
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.selectedIndex = indexPath.row
            self.objBoatDetailsData?.packages?[indexPath.row].isAdded = true
            self.packages = self.objBoatDetailsData?.packages?[indexPath.row]
            self.packageTableView.reloadData()
    }
    
    func navigateToRestaurantContainer(){
        let controller = RestaurantsContainerVC.instantiate()
        controller.objBoatDetailsData = self.objBoatDetailsData
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
