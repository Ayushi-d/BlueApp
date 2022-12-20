//
//  RestaurantsContainerVC.swift
//  BLUE
//
//  Created by Bhikhu on 05/10/22.
//

import UIKit
import XLPagerTabStrip

/// RestaurantsContainerVC Handle the Restuaranet container tab  which there is 2 tabs
class RestaurantsContainerVC: ButtonBarPagerTabStripViewController, StoryboardSceneBased {

    /// Storyboard variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)
    var objBoatDetailsData: BoatDetailsData?
    var packageArr: Packages?
    override func viewDidLoad() {
        configureOnViewDidLoad()

        super.viewDidLoad()
    }

    // MARK: -Actions

    // MARK: -Private Methods
    private func configureOnViewDidLoad() {
        
        setupTab()
    }
    
    private var productVM: ProductVM = {
        return ProductVM()
    }()
    
    private var objeProductCategory = [ProductCategory]()
    
    private  func setupTab(){
        
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = Color.Color.buttonColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

    }
    // MARK: - PagerTabStripDataSource

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = RestaurantsVC.instantiate()
        child_1.itemInfo = "Resturant"
        child_1.objBoatDetailsData = self.objBoatDetailsData
        child_1.packageArr = packageArr
        let child_2 = RestaurantsVC.instantiate()
        child_2.itemInfo = "Accessories"
        child_2.objBoatDetailsData = self.objBoatDetailsData
        child_2.packageArr = packageArr
        return [child_1, child_2]
    }
    
    @IBAction func notificationTapped(_ sender: Any) {
        self.pushVC(controller: NotificationVC.instantiate())
    }
}

