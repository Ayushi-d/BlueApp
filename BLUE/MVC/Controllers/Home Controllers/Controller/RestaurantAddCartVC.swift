//
//  RestaurantAddCartVC.swift
//  BLUE
//
//  Created by Bhikhu on 06/10/22.
//

import UIKit

class RestaurantAddCartVC: UIViewController, StoryboardSceneBased {
  
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)
    @IBOutlet weak var img: UIImageView!

    @IBOutlet weak var quantityLabel: AppBaseLabel!
    @IBOutlet weak var price: AppBaseLabel!
    @IBOutlet weak var productName: AppBaseLabel!
    @IBOutlet weak var productDescription: AppBaseLabel!
    @IBOutlet weak var qunatityView: UIView!
    @IBOutlet weak var outofstockLabel: AppBaseLabel!
    @IBOutlet weak var cartBtn:BlueButton!
    var objBoatDetailsData: BoatDetailsData?
    var packageArr: Packages?

    var id = Int()
    let urlDataProvider = URLDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.image = UIImage(named: "ic_dummyboat")
        getProductDetails()
    }

    //private Functions
    private var  productVM: ProductVM = {
        return ProductVM()
    }()
    
    private var objProductDetail: ProductDetails?
    
    func getProductDetails(){
        productVM.saveProductDetailData(id: id)
        productVM.getProductdetailData { [self] success in
            if success{
                objProductDetail = productVM.objProductDetailModel?.data
                setData()
            }
        }
    }
    
    func setData(){
        price.text = (objProductDetail?.price)! + "KWD"
        productName.text = objProductDetail?.name
        productDescription.text = objProductDetail?.description
        img.setImageUsingKF(string: objProductDetail?.image ?? "", placeholder: PlaceHolderImages.homelaceHolder,isFited: false)
        self.qunatityView.isHidden = objProductDetail?.stock ?? 0 > 0 ? false : true
        self.outofstockLabel.isHidden = objProductDetail?.stock ?? 0 > 0 ? true : false
        self.cartBtn.isHidden = objProductDetail?.stock ?? 0 > 0 ? false : true
    }
    
    // MARK: Actions
    @IBAction func btnAddtoCartTapped(_ sender: Any) {
       // self.pushVC(controller: CartVC.instantiate())
        self.addToCart()
    }
    
    @IBAction func viewCartBtnTapped(_ sender: Any) {
        let vc = CartVC.instantiate()
        vc.objBoatDetailsData = self.objBoatDetailsData
        vc.packageArr = packageArr
        self.pushVC(controller: vc)
    }
    
    @IBAction func btnCartTapped(_ sender: Any) {
        let vc = CartVC.instantiate()
        vc.objBoatDetailsData = self.objBoatDetailsData
        vc.packageArr = packageArr
        self.pushVC(controller: vc)
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        quantityLabel.text = "\((Int(quantityLabel.text!) ?? 0) + 1)"
    }
    
    @IBAction func minusBtnTapped(_ sender: Any) {
        if Int(quantityLabel.text!) ?? 0 > 1{
            quantityLabel.text = "\((Int(quantityLabel.text!) ?? 0) - 1)"
        }
    }
    
    func addToCart(){
        let productPrice = Double(objProductDetail?.price ?? "0")
        let productQuantity = Int(quantityLabel.text!)
        let requestBody : [String: Any] = ["id": 0,"product_id":objProductDetail?.id ?? 0,"qty":productQuantity!,"total":productPrice!*Double(productQuantity!)]
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/cart")!, httpMethod: RequestMethod.post, requestBody: requestBody.percentEncoded()) { result, statusCode, isSuccess, error in
            print(result)
            DispatchQueue.main.async {
                AlertMesage.show(isSuccess ? .success : .error, message: result["message"] as? String ?? "")
            }
        }
    }
}
