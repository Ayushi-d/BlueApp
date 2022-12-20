//
//  PaymentVC.swift
//  BLUE
//
//  Created by Bhikhu on 08/10/22.
//

import UIKit
import Moya

struct SummaryModel{
    let product: String
    let price: String
}

class RestaurantPaymentVC: UIViewController, StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)

    /// Storyboard  variable
    @IBOutlet weak var tblMethodHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var tblPaymentMethod: UITableView!
    @IBOutlet weak var tblSummary: UITableView!
    @IBOutlet weak var tblSummarHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var boatName: AppBaseLabel!
    @IBOutlet weak var boatImage: UIImageView!
    @IBOutlet weak var timeLabel: AppBaseLabel!
    @IBOutlet weak var dateLabel: AppBaseLabel!
    @IBOutlet weak var couponField: UITextField!
    @IBOutlet weak var pickUpLabel: AppBaseLabel!
    @IBOutlet weak var totalAmountLabel: AppBaseLabel!
    
    let paymentImages = [UIImage.init(named: "ic_mastercard"),UIImage.init(named: "ic_visa")]
    var arrSummary = [SummaryModel]()
    var selectedIndex : Int?
    var cartArr = [CartModel]()
    var packageArr : Packages?
    var objBoatDetailsData: BoatDetailsData?
    var cartTotalAmount = 0.0
    var packageTotalAmount = 0.0
    let urlDataProvider = URLDataProvider()
    var grandTotal = 0.0
    var couponData: CouponModel?
    var start = ""
    var end = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
    }
    
    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        let obj1 = SummaryModel(product: "Catamaran Boats", price: "50.000 KWD")
        let obj2 = SummaryModel(product: "Chicken Burger ", price: "3.500 KWD")
        let obj3 = SummaryModel(product: "Mix Kabab ", price: "7.500 KWD")
        let obj4 = SummaryModel(product: "Pan Cakes ", price: "4.800 KWD")
        let obj5 = SummaryModel(product: "Chicken Pizza ", price: "5.000 KWD")
        arrSummary.append(obj1)
        arrSummary.append(obj2)
        arrSummary.append(obj3)
        arrSummary.append(obj4)
        arrSummary.append(obj5)
        self.boatName.text = self.objBoatDetailsData?.name ?? ""
        self.boatImage.setImageUsingKF(string: self.objBoatDetailsData?.featuredImage ?? "", placeholder: PlaceHolderImages.homelaceHolder)
        self.pickUpLabel.text = self.objBoatDetailsData?.pickupAddress ?? ""
        self.dateLabel.text = boatBookTimeModel?.selectedDate ?? ""
        self.timeLabel.text = (boatBookTimeModel?.startTime ?? "").shortTime() + " to " + (boatBookTimeModel?.endTime ?? "").shortTime()
        print((boatBookTimeModel?.selectedDate?.numericDate() ?? "") + " " + (boatBookTimeModel?.startTime ?? "") + ":00")
        if packageArr == nil && cartArr.isEmpty{
            self.totalAmountLabel.text = "\(Double(objBoatDetailsData?.startingFrom ?? "0.0") ?? 0.0)"
            self.grandTotal = (Double(objBoatDetailsData?.startingFrom ?? "0.0") ?? 0.0)
        }else if packageArr == nil && !cartArr.isEmpty{
            for i in cartArr{
                cartTotalAmount = cartTotalAmount + (i.total?.double)!
            }
            self.totalAmountLabel.text = "\((Double(objBoatDetailsData?.startingFrom ?? "0.0") ?? 0.0) + cartTotalAmount)"
            self.grandTotal = (Double(objBoatDetailsData?.startingFrom ?? "0.0") ?? 0.0) + cartTotalAmount
        }else if packageArr != nil && cartArr.isEmpty{
            packageTotalAmount = packageTotalAmount + (packageArr!.price?.double)!
            self.totalAmountLabel.text = "\((Double(objBoatDetailsData?.startingFrom ?? "0.0") ?? 0.0) + packageTotalAmount)"
            self.grandTotal = (Double(objBoatDetailsData?.startingFrom ?? "0.0") ?? 0.0) + packageTotalAmount
        }
        else{
            packageTotalAmount = packageTotalAmount + (packageArr!.price?.double)!
            for i in cartArr{
                cartTotalAmount = cartTotalAmount + (i.total?.double)!
            }
            self.totalAmountLabel.text = "\((Double(objBoatDetailsData?.startingFrom ?? "0.0") ?? 0.0) + packageTotalAmount + cartTotalAmount)"
            self.grandTotal = (Double(objBoatDetailsData?.startingFrom ?? "0.0") ?? 0.0) + packageTotalAmount + cartTotalAmount
        }
        tblSummary.register(cellType: PaymentFirstSectionCell.self)
        tblPaymentMethod.register(cellType: PaymentCell.self)
        tblSummary.estimatedRowHeight = 62
        tblSummary.rowHeight = UITableView.automaticDimension
        tblSummary.reloadData()
    }
    
    // MARK: IB Actions
    @IBAction func btnPayConfimrTapped(_ sender: Any) {
        self.boatBookingAPI()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        if couponField.text == ""{
            self.couponField.shake()
            AlertMesage.show(.error, message: "Please Enter Coupon")
        }else{
            self.couponAPI()
        }
    }
    
    func couponAPI(){
        let requestBody: [String: Any] = ["code":couponField.text!,"amount":"\(self.grandTotal)"]
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/validate-coupon")!, httpMethod: .post, requestBody: requestBody.percentEncoded(), resultType: BaseResponse<CouponModel>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    AlertMesage.show(.success, message: "Coupon Code Applied")
                    self.couponData = result?.data
                    self.totalAmountLabel.text = "\(self.grandTotal - (Double(result?.data?.discount_amount ?? "0.0")?.rounded() ?? 0.0))"
                }
            }else{
                DispatchQueue.main.async {
                    AlertMesage.show(.error, message: "Invalid Coupon Code")
                }
            }
        }
    }
    
    func boatBookingAPI(){
        var requestBody: [String: Any] = ["coupon_id":"\(self.couponData?.coupon_id ?? 0)"
                                          ,"coupon_amount":self.couponData?.discount_amount ?? "",
                                          "total":"\(grandTotal)",
                                          "grand_total":self.totalAmountLabel.text!,
                                          "boat_id":objBoatDetailsData?.id ?? 0,
                                          "destination_id":"\(UserDefaults.standard.object(forKey: "destinationID") as? Int ?? 0)"   ,
                                          "package_id":"\(self.packageArr?.id ?? 0)",
                                          "boat_category":"\(self.objBoatDetailsData?.category ?? 0)",
                                          "start":(boatBookTimeModel?.selectedDate?.numericDate() ?? "") + " " + (boatBookTimeModel?.startTime ?? "") + ":00",
                                          "end":(boatBookTimeModel?.selectedDate?.numericDate() ?? "") + " " + (boatBookTimeModel?.endTime ?? "") + ":00",
                                          "boat_total":self.objBoatDetailsData?.startingFrom ?? "",
                                          "boat_grand_total":self.totalAmountLabel.text!]
        if !cartArr.isEmpty{
            var product = [[String:String]]()
            for i in cartArr{
                product.append(["type": i.type ?? "", "product_id":"\(i.product_id ?? 0)","grand_total":i.total ?? "" ,"qty":"\(i.qty ?? 0)"])
            }
            requestBody["product"] = product
        }

        Network.request(Service.boatBooking(param: requestBody)) { (jsonResponse) in
            if let aDictMetaData = jsonResponse?[API.Response.message].string, !aDictMetaData.isEmpty {
                    if aDictMetaData == "Success"{
                        self.pushVC(controller: BookingConfirmedVC.instantiate())
                    }
                } else {
                    AlertMesage.show(.error, message: "Something went Wrong")
                }
        }
    }
    
}

// MARK: UITableViewDelegate
extension RestaurantPaymentVC :UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblSummary {
            if (packageArr == nil && cartArr.count == 0){
                return 1
            }else if (packageArr != nil && cartArr.count == 0){
                return 2
            }else if (packageArr != nil && cartArr.count != 0){
                return 2 + (cartArr.count)
            }else{
                return 1 + (cartArr.count)
            }
            //return 1 + (packageArr == nil ? cartArr.count : 1)
        }else if tableView == tblPaymentMethod {
            return paymentImages.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if tableView == tblSummary {
             let aCell: PaymentFirstSectionCell = tableView.dequeueReusableCell(for: indexPath)
             aCell.selectionStyle = .none
             if indexPath.row == 0{
                 aCell.lblProduct.text = self.objBoatDetailsData?.name ?? ""
                 aCell.lblPrice.text = (self.objBoatDetailsData?.startingFrom ?? "") + " KWD"
             }else{
                 if  packageArr == nil{
                     aCell.cellConfig(with: cartArr[indexPath.row-1])
                 }else{
                     if indexPath.item == 1{
                         aCell.cellConfigwithPackage(with: packageArr!)
                     }else{
                         aCell.cellConfig(with: cartArr[indexPath.row-2])
                     }
                 }
//                 if packageArr == nil{
//                     aCell.cellConfig(with: cartArr[indexPath.row-1])
//                 }else{
//                     aCell.cellConfigwithPackage(with: packageArr!)
//                 }
             }
             return aCell
         } else if tableView == tblPaymentMethod {
             let aCell: PaymentCell = tableView.dequeueReusableCell(for: indexPath)
             aCell.radioImage.image = indexPath.row == selectedIndex ?? 0 ? UIImage.init(named: "ic_selectedRadio") : UIImage.init(named: "ic_unselectedRadio")
             aCell.paymentImage.image = paymentImages[indexPath.row]
             return aCell
         }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == tblSummary {
            Utility.delay(0) {
                self.tblSummarHeightConstant.constant = self.tblSummary.contentSize.height
            }
        } else if tableView == tblPaymentMethod {
            Utility.delay(0) {
                self.tblMethodHeightConstant.constant = self.tblPaymentMethod.contentSize.height
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblPaymentMethod {
            self.selectedIndex = indexPath.row
            tblPaymentMethod.reloadData()
        }
    }
}

extension Data
{
    func printJSON()
    {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            print(JSONString)
        }
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
