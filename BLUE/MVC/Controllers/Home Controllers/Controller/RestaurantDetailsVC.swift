//
//  RestaurantDetailsVC.swift
//  BLUE
//
//  Created by Bhikhu on 06/10/22.
//

import UIKit

struct RestaurantDetailsModel {
    let title: String
    let description: String
    let price: String
}
class RestaurantDetailsVC: UIViewController , StoryboardSceneBased {

    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblTitle: AppBaseLabel!
    @IBOutlet weak var lblDescription: AppBaseLabel!
    @IBOutlet weak var lblHeaderTitle: AppBaseLabel!
    @IBOutlet weak var noProdutcLabel: AppBaseLabel!
    @IBOutlet weak var txtSearch: UISearchBar!

    var objBoatDetailsData: BoatDetailsData?
    var packageArr: Packages?
    
    private lazy var productVM: ProductVM = {
        return ProductVM()
    }()
    
    private var objProductList = [ProductList]()
    private var filterobjProductList = [ProductList]()
    
    var isfromRestaurant  = false
    var subCategoryId = Int()
    var titleString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
    }
    // MARK: Actions

    
    
    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        
        getProductListApi()
        tblView.register(cellType: RestaurantDetailsCell.self)
        tblView.separatorStyle = .none
        tblView.estimatedRowHeight = 116
        lblTitle.text = titleString
        lblDescription.isHidden = isfromRestaurant ? false : true
        lblHeaderTitle.text = isfromRestaurant ? Localizable.RestaurentContainer.restaurants : Localizable.RestaurentContainer.accessories
        
    }
    

    
    private func getProductListApi(){
        productVM.saveProductData(page: 1, subcategory: "\(subCategoryId)")
        productVM.getProductListData { success in
            if success{
                self.objProductList = (self.productVM.objProductDataModel?.data)!
                self.noProdutcLabel.isHidden = self.objProductList.count == 0 ? false : true
                self.tblView.reloadData()
            }
        }
    }
    
    
    @IBAction func cartTapped(_ sender: Any) {
        let vc = CartVC.instantiate()
        vc.objBoatDetailsData = self.objBoatDetailsData
        vc.packageArr = packageArr
        self.pushVC(controller: vc)
    }
    
}

// MARK: UITableViewDelegate
extension RestaurantDetailsVC :UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if txtSearch.text != ""{
            return self.filterobjProductList.count
        }
        return objProductList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell: RestaurantDetailsCell = tableView.dequeueReusableCell(for: indexPath)
         if txtSearch.text != ""{
             aCell.cellConfig(with: filterobjProductList[indexPath.row])
         }else{
             aCell.cellConfig(with: objProductList[indexPath.row])
         }
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = RestaurantAddCartVC.instantiate()
        controller.objBoatDetailsData = self.objBoatDetailsData
        controller.packageArr = packageArr
        controller.id = txtSearch.text != "" ? filterobjProductList[indexPath.row].id ?? 0 : objProductList[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(controller, animated: true)
        
//        self.pushVC(controller: RestaurantAddCartVC.instantiate())
        
    }
}

extension RestaurantDetailsVC: UISearchBarDelegate{
    
    private func filterProductList(for searchText: String){
        self.filterobjProductList = objProductList.filter{ products in
            return products.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
        self.tblView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        filterProductList(for: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
