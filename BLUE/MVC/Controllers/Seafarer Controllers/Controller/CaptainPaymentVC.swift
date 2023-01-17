//
//  CaptainPaymentVC.swift
//  BLUE
//
//  Created by Bhikhu on 15/10/22.
//

import UIKit

class CaptainPaymentVC: UIViewController , StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.seafarer.rawValue, bundle: nil)

    
    /// Storyboard  variable
    @IBOutlet weak var total_amount: AppBaseLabel!
    @IBOutlet weak var tblMethodHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var tblPaymentMethod: UITableView!
    @IBOutlet weak var tblSummary: UITableView!
    @IBOutlet weak var tblSummarHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var couponField: UITextField!
    let paymentImages = [UIImage.init(named: "ic_mastercard"),UIImage.init(named: "ic_visa")]
    var arrSummary = [SummaryModel]()
    var selectedIndex : Int?
    var couponData: CouponModel?
    var grandTotal = 0.0

    var seafarerData : SeafarerData?
    let urlProvider = URLDataProvider()
    var completionblock: ((Bool?) -> Void)?
    var isCouponApplied = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()

    }
    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        let obj1 = SummaryModel(product: "Catamaran Boats", price: "50.000 KWD")
        arrSummary.append(obj1)
        tblSummary.register(cellType: PaymentFirstSectionCell.self)
        tblPaymentMethod.register(cellType: PaymentCell.self)
        tblSummary.estimatedRowHeight = 62
        tblSummary.rowHeight = UITableView.automaticDimension
        tblSummary.reloadData()
        self.total_amount.text = (self.seafarerData?.amount ?? "0.0") + " KWD"
        self.grandTotal = (Double(self.seafarerData?.amount ?? "0.0") ?? 0.0)

    }
    // MARK: IB Actions
    @IBAction func btnPayConfimrTapped(_ sender: Any) {
        bookingSeafarer()
    }

    @IBAction func applyTapped(_ sender: Any) {
        if couponField.text != ""{
            if !isCouponApplied{
                couponAPI()
            }else{
                AlertMesage.show(.warning, message: "Coupon Already Applied")
            }
        }else{
            AlertMesage.show(.error, message: "Enter Coupon code")
        }
    }
    
    func bookingSeafarer(){
        let requestBody = ["seafarer_id": "\(self.seafarerData?.id ?? 0)","amount":self.seafarerData?.amount ?? "0.00","coupon_id":"\(self.couponData?.coupon_id ?? 0)","grand_total":"\(self.grandTotal)"]
        urlProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/seafarer-booking")!, httpMethod: .post, requestBody: requestBody.percentEncoded()) { result, statusCode, isSuccess, error in
            print(result)
            DispatchQueue.main.async {
                if isSuccess{
                    DispatchQueue.main.async {
                        self.completionblock?(true)
                        self.poptoViewController()
                    }
                }else{
                    AlertMesage.show(.error, message: "Error")
                }
            }
        }
    }
    
    func couponAPI(){
        let requestBody: [String: Any] = ["code":couponField.text!,"amount":self.seafarerData?.amount ?? "0.0"]
        urlProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/validate-coupon")!, httpMethod: .post, requestBody: requestBody.percentEncoded(), resultType: BaseResponse<CouponModel>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    AlertMesage.show(.success, message: "Coupon Code Applied")
                    self.isCouponApplied = true
                    self.couponData = result?.data
                    self.total_amount.text = "\(self.grandTotal - (Double(result?.data?.discount_amount ?? "0.0")?.rounded() ?? 0.0))" + " KWD"
                    self.grandTotal = self.grandTotal - (Double(result?.data?.discount_amount ?? "0.0")?.rounded() ?? 0.0)
                }
            }else{
                DispatchQueue.main.async {
                    AlertMesage.show(.error, message: "Invalid Coupon Code")
                }
            }
        }
    }
    
}

// MARK: UITableViewDelegate
extension CaptainPaymentVC :UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblSummary {
            return 1
        }else if tableView == tblPaymentMethod {
            return paymentImages.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblSummary {
            let aCell: PaymentFirstSectionCell = tableView.dequeueReusableCell(for: indexPath)
            guard let seafarerData else {return UITableViewCell()}
            aCell.cellConfigSeafarer(with: seafarerData)
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
