//
//  RestaurantsVC.swift
//  BLUE
//
//  Created by Bhikhu on 05/10/22.
//

import UIKit
import XLPagerTabStrip

struct RestaurantModel {
    let title: String
    let description: String
    
}

class RestaurantsVC: UIViewController, StoryboardSceneBased,IndicatorInfoProvider  {

    
    var itemInfo: IndicatorInfo = "View"
    var arrRestaurant = [RestaurantModel]()
    var objBoatDetailsData: BoatDetailsData?
    var packageArr: Packages?

    @IBOutlet weak var noProdctsLabel: AppBaseLabel!
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var resturantCollection: UITableView!

    {
        didSet{
            categoryCollection.register(UINib(nibName: "RestaurantHeaderCollCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantHeaderCollCell")
        }
    }
    
   
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo

    }
    
    private lazy var productVM: ProductVM = {
        return ProductVM()
    }()
    
    private var objProductSubCategory = [ProductSubCategory]()
    
    private var objProductCategory = [ProductCategory]()
    //get subcategory
    func getProductSubcategoryApi(categoryId: String){
        productVM.saveProductSubCategoryData(categoryId: categoryId)
        productVM.getProductSubCategoryData { [self] success in
            if success{
                self.objProductSubCategory.removeAll()
                self.objProductSubCategory = (productVM.objSubCategoryDataModel?.data)!
                self.noProdctsLabel.isHidden = self.objProductSubCategory.count == 0 ? false : true
                resturantCollection.reloadData()
            }else{
                self.objProductSubCategory.removeAll()
                self.noProdctsLabel.isHidden = false
                resturantCollection.reloadData()
            }
        }
    }
    //get category
    func getCategoryApi(){
        productVM.saveProductCategoryData(type: itemInfo.title == "Resturant" ? "restaurant" : "Accessories")
        productVM.getProductCategoryData(completion: { success in
            if success{
                self.objProductCategory = (self.productVM.objCategoryDataModel?.data)!
                self.categoryCollection.reloadData()
                self.getProductSubcategoryApi(categoryId: "\(self.objProductCategory[0].id ?? 1)" )

            }
        })
    }
    /// Storyboard variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        let obj1 = RestaurantModel(title: "Jamawar Crowne Plaza Kuwait", description: "Indian, Asian, Vegetarian Friendly")
        let obj2 = RestaurantModel(title: "Mais Alghanim", description: "Lebanese, Grill, Middle Eastern")
        let obj3 = RestaurantModel(title: "Freij Sweileh", description: "Middle Eastern, Vegetarian Friendly, Halal")
        getCategoryApi()
        arrRestaurant.append(obj1)
        arrRestaurant.append(obj2)
        arrRestaurant.append(obj3)
        resturantCollection.rowHeight = UITableView.automaticDimension
        resturantCollection.separatorStyle = .none
        resturantCollection.showsVerticalScrollIndicator = false
        resturantCollection.showsHorizontalScrollIndicator = false
        resturantCollection.register(cellType: RestaurantCell.self)
        resturantCollection.register(cellType: RestaurantHeadeViewCell.self)
        resturantCollection.estimatedRowHeight = 440
    }
  
    // MARK: - Private Methods
    private func configureOnViewDidLoad() {
    }

}

extension RestaurantsVC: UITableViewDelegate, UITableViewDataSource {
  
     func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return objProductSubCategory.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell: RestaurantCell = tableView.dequeueReusableCell(for: indexPath)
        aCell.cellConfig(with: objProductSubCategory[indexPath.row])
        return aCell
    }
    
//    override  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let aCell: RestaurantHeadeViewCell = tableView.dequeueReusableCell(for: IndexPath(row: 0, section: 0))
//        return aCell
//    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = RestaurantDetailsVC.instantiate()
        controller.isfromRestaurant = itemInfo.title == "Resturant" ? true : false
        controller.objBoatDetailsData = self.objBoatDetailsData
        controller.packageArr = packageArr
        controller.subCategoryId = objProductSubCategory[indexPath.row].id ?? 1
        controller.titleString = objProductSubCategory[indexPath.row].name ?? "sd"
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

extension RestaurantsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objProductCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "RestaurantHeaderCollCell", for: indexPath) as? RestaurantHeaderCollCell else {return UICollectionViewCell()}
        cell.configcell(with: objProductCategory[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        getProductSubcategoryApi(categoryId: "\(objProductCategory[indexPath.item].id ?? 0)" )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.categoryCollection.frame.width/4.2, height: 80)
    }
    
}



