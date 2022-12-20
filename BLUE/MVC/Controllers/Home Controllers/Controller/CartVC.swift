//
//  CartVC.swift
//  BLUE
//
//  Created by Bhikhu on 08/10/22.
//

import UIKit


class CartVC: UIViewController, StoryboardSceneBased, CartDelegate {
    

    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)

    let urlDataProvider = URLDataProvider()
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtQueries: UITextView!
    @IBOutlet var viewFooter: UIView!
    var objBoatDetailsData: BoatDetailsData?
    var packageArr: Packages?
    var arrCart = [CartModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
    }
    

    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        getCartProducts()
        viewFooter.frame = CGRect(x: 0, y: 0, width: tblView.frame.size.width, height: 350)
        tblView.tableFooterView = viewFooter
        tblView.register(cellType: CartCell.self)
        tblView.separatorStyle = .none
        tblView.estimatedRowHeight = 130
        txtQueries.delegate = self
        txtQueries.text = "Option to Write"
        txtQueries.textColor = UIColor.lightGray
    }
    
    
    
    @IBAction func btnCheckoutTapped(_ sender: Any) {
        let vc = RestaurantPaymentVC.instantiate()
        vc.cartArr = arrCart
        vc.objBoatDetailsData = self.objBoatDetailsData
        vc.packageArr = packageArr
        self.pushVC(controller: vc)
    }
    
    func getCartProducts(){
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/cart")!, httpMethod: RequestMethod.get, requestBody: nil, resultType: BaseResponse<[CartModel]>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                self.arrCart = result?.data ?? []
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    AlertMesage.show(.error, message: result?.message ?? "")
                }
            }
        }
    }
    
    func plusTapped(tag: Int) {
        addToCart(tag: tag, isAdd: true)
    }
    
    func minusTapped(tag: Int) {
        addToCart(tag: tag, isAdd: false)
    }
    
    func deleteTapped(tag: Int) {
        self.deleteCart(tag: tag)
    }
    
    func deleteCart(tag: Int){
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/cart/"+"\(arrCart[tag].id ?? 0)")!, httpMethod: RequestMethod.delete, requestBody: nil) { result, statusCode, isSuccess, error in
            print(result)
            DispatchQueue.main.async {
                AlertMesage.show(isSuccess ? .success : .error, message: result["message"] as? String ?? "")
                self.arrCart.removeAll()
                self.getCartProducts()
            }
        }
    }
    
    func addToCart(tag: Int, isAdd: Bool){
        let productPrice = Double(arrCart[tag].product_price ?? "0")
        let productQuantity = isAdd ? (arrCart[tag].qty ?? 0) + 1 : (arrCart[tag].qty ?? 0) - 1
        let requestBody : [String: Any] = ["id": arrCart[tag].id ?? 0,"product_id":arrCart[tag].product_id ?? 0,"qty":productQuantity,"total":productPrice!*Double(productQuantity)]
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/cart")!, httpMethod: RequestMethod.post, requestBody: requestBody.percentEncoded()) { result, statusCode, isSuccess, error in
            print(result)
            DispatchQueue.main.async {
                AlertMesage.show(isSuccess ? .success : .error, message: result["message"] as? String ?? "")
                self.arrCart.removeAll()
                self.getCartProducts()
            }
        }
    }
    
}

// MARK: UITableViewDelegate
extension CartVC :UITableViewDelegate, UITableViewDataSource {
  
   
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return arrCart.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell: CartCell = tableView.dequeueReusableCell(for: indexPath)
         aCell.cellConfig(with: arrCart[indexPath.row])
         aCell.delegate = self
         aCell.plusButton.tag = indexPath.row
         aCell.minusButton.tag = indexPath.row
         aCell.deleteButton.tag = indexPath.row
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantAddCartVC") as! RestaurantAddCartVC
//        vc.id = arrCart[indexPath.row].product_id ?? 0
//        self.navigationController?.pushViewController(vc, animated: true)
        //self.pushVC(controller: RestaurantAddCartVC.instantiate())
    }
}

// MARK: - UITextViewDelegate
extension CartVC: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {

        if !txtQueries.text!.isEmpty && txtQueries.text! == "Option to Write" {
            txtQueries.text = ""
            txtQueries.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
    
        if txtQueries.text.isEmpty {
            txtQueries.text = "Option to Write"
            txtQueries.textColor = UIColor.lightGray
        }
    }
}
