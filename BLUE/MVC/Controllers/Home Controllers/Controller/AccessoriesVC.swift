//
//  Accessories.swift
//  BLUE
//
//  Created by Bhikhu on 05/10/22.
//

import UIKit
import XLPagerTabStrip

class AccessoriesVC: UITableViewController, StoryboardSceneBased,IndicatorInfoProvider  {
    
    var itemInfo: IndicatorInfo = "View"
    var arrRestaurant = [RestaurantModel]()
    init(style: UITableView.Style, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        configureOnViewDidLoad()
        return itemInfo
    }
    
    
    /// Storyboard variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        let obj1 = RestaurantModel(title: "Alsabih Marine Equipment", description: "Indian, Asian, Vegetarian Friendly")
        let obj2 = RestaurantModel(title: "Mercman Marine Inc", description: "Lebanese, Grill, Middle Eastern")
        let obj3 = RestaurantModel(title: "Al Dhaen Kuwait", description: "Middle Eastern, Vegetarian Friendly, Halal")
        
        getCategoryApi()
        
        arrRestaurant.append(obj1)
        arrRestaurant.append(obj2)
        arrRestaurant.append(obj3)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(cellType: RestaurantCell.self)
        tableView.register(cellType: AccessoriesHeaderViewCell.self)
        tableView.estimatedRowHeight = 440
    }
  
    // MARK: - Private Methods
    private func configureOnViewDidLoad() {
    }
    
    private lazy var productVM: ProductVM = {
        return ProductVM()
    }()
    
    private var objProductSubCategory = [ProductSubCategory]()
    
    private var objProductCategory = [ProductCategory]()
    //get subcategory
    func getProductSubcategoryApi(){
        productVM.saveProductSubCategoryData(categoryId: "2")
        productVM.getProductSubCategoryData { [self] success in
            if success{
                self.objProductSubCategory = (productVM.objSubCategoryDataModel?.data)!
                tableView.reloadData()
            }
        }
    }
    //get category
    func getCategoryApi(){
        productVM.saveProductCategoryData(type: "accessories")
        productVM.getProductCategoryData(completion: { success in
            if success{
                self.objProductCategory = (self.productVM.objCategoryDataModel?.data)!
                self.getProductSubcategoryApi()
            }
        })
    }
    
    
    
}

extension AccessoriesVC {
  
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return objProductSubCategory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell: RestaurantCell = tableView.dequeueReusableCell(for: indexPath)
        aCell.cellConfig(with: objProductSubCategory[indexPath.row])
        aCell.img.image = UIImage(named: "im_boat")
        aCell.lblDescription.isHidden = true
        return aCell
    }
    override  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let aCell: AccessoriesHeaderViewCell = tableView.dequeueReusableCell(for: IndexPath(row: 0, section: 0))
        return aCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = RestaurantDetailsVC.instantiate()
        controller.isfromRestaurant = false
        controller.subCategoryId = objProductSubCategory[indexPath.row].category_id ?? 2
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
