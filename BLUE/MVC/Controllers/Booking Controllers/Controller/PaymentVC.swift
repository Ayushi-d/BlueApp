//
//  PaymentVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 25/09/22.
//

import UIKit
import Hero

class PaymentVC: UIViewController {
    
    let paymentImages = [UIImage.init(named: "ic_mastercard"),UIImage.init(named: "ic_visa")]
    
    var bookingDetails: BookingModel?
    let urlProvider = URLDataProvider()
    var startTime = ""
    var endTime = ""
    var grandTotal = 0.0
    var couponData: CouponModel?
    var isCouponApplied = false
    var boatInfo: BoatInfoModel?
    
    @IBOutlet weak var parkingAddress: UILabel!
    @IBOutlet weak var boatsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var couponField: UITextField!
    @IBOutlet weak var applyButton: BlueButton!
    @IBOutlet weak var boatimg: UIImageView!

    @IBOutlet weak var paymentTableView: UITableView!{
        didSet{
            paymentTableView.register(UINib(nibName: "PaymentCell", bundle: nil), forCellReuseIdentifier: "PaymentCell")
        }
    }
    let urlDataProvider = URLDataProvider()
    var selectedIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewDidload()
    }
    
    func configureViewDidload(){
        self.boatsLabel.text = self.bookingDetails?.boatName ?? ""
        self.timeLabel.text = (self.bookingDetails?.startTime ?? "") + " to " + (self.bookingDetails?.endTime ?? "")
        self.dateLabel.text = (self.bookingDetails?.startDate ?? "")
        self.priceLabel.text = self.bookingDetails?.totalPrice ?? ""
        self.totalPriceLabel.text = self.bookingDetails?.totalPrice ?? ""
        self.daysLabel.text = (self.bookingDetails?.startDate ?? "")
        //let startTimeToSend = self.bookingDetails?.startTime ?? ""
        self.startTime = String(self.bookingDetails?.startTime.dropLast(2) ?? "")
        self.endTime = String(self.bookingDetails?.endTime.dropLast(2) ?? "")
        print("date-----",self.bookingDetails!.startDate.shortDate())

    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
    
    @IBAction func continueTapped(_ sender: Any) {
        bookParkingAPI()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        if couponField.text == ""{
            self.couponField.shake()
            AlertMesage.show(.error, message: "Please Enter Coupon")
        }else{
            if !isCouponApplied{
                self.couponAPI()
            }else{
                AlertMesage.show(.error, message: "Coupon Already Applied")
            }
        }
    }
    
    func navigateToSuccess(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingDoneVC") as! BookingDoneVC
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func couponAPI(){
        self.grandTotal = self.bookingDetails?.totalPrice.double ?? 0.0
        let requestBody: [String: Any] = ["code":couponField.text!,"amount":"\(self.grandTotal)"]
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/validate-coupon")!, httpMethod: .post, requestBody: requestBody.percentEncoded(), resultType: BaseResponse<CouponModel>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    AlertMesage.show(.success, message: "Coupon Code Applied")
                    self.isCouponApplied = true
                    self.couponData = result?.data
                    self.totalPriceLabel.text = "\(self.grandTotal - (Double(result?.data?.discount_amount ?? "0.0")?.rounded() ?? 0.0))"
                }
            }else{
                DispatchQueue.main.async {
                    AlertMesage.show(.error, message: "Invalid Coupon Code")
                }
            }
        }
    }
    
    func bookParkingAPI(){
        
        let fromDate = "\(self.bookingDetails!.startDate.shortDate())" + " " + "\(self.startTime.trim()+":00")"
        let toDate = "\(self.bookingDetails!.endDate.shortDate())" + " " + "\(self.endTime.trim()+":00")"
        let rquestBody :[String: Any] = ["parking_id":"\(bookingDetails!.parkingID)","from_date":fromDate,"to_date":toDate,"price": self.totalPriceLabel.text!, "grand_total":self.totalPriceLabel.text!, "coupon_id":"\(couponData?.coupon_id ?? 0)","payment_method":"card","payment_status":"success","transaction_id":"123456","name":boatInfo?.name ?? "","height":boatInfo?.boatHeight ?? "","width":boatInfo?.boatWidth ?? "","boat_type":boatInfo?.boatType ?? "","image":boatInfo?.boatImages ?? []]
        
        urlProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/parking-booking")!, httpMethod: .post, requestBody: rquestBody.percentEncoded()) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    self.navigateToSuccess()
                }
            }
        }
    }
}

//MARK: - UITableView Setup
extension PaymentVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = paymentTableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as? PaymentCell else {return UITableViewCell() }
        cell.radioImage.image = indexPath.row == selectedIndex ?? 0 ? UIImage.init(named: "ic_selectedRadio") : UIImage.init(named: "ic_unselectedRadio")
        cell.paymentImage.image = paymentImages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        paymentTableView.reloadData()
    }
    
}


extension String{

    func shortDate() -> Self{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date!)
    }
    
    func numericDate() -> Self{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date!)
    }
    
    func servertoShortDate() -> Self{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        return dateFormatter.string(from: date!)
    }
    
    func shortTime() -> Self{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date!)
    }
    
    func servertoShortTime() -> Self{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date!)
    }
    
}
