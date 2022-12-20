//
//  BookingDetailVC.swift
//  BLUE
//
//

import UIKit

class BookingDetailVC: UIViewController {
    
    @IBOutlet weak var pickupadrsLabel: AppBaseLabel!
    
    @IBOutlet weak var captainName: AppBaseLabel!
    @IBOutlet weak var boatName: AppBaseLabel!
    @IBOutlet weak var bookinDate: AppBaseLabel!
    @IBOutlet weak var bookingTime: AppBaseLabel!
    @IBOutlet weak var totalAmountLabel: AppBaseLabel!
    @IBOutlet weak var cartAmountLabel: AppBaseLabel!
    @IBOutlet weak var boatImage: UIImageView!
    @IBOutlet weak var tblVIew: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    var id: Int?
    let urlProvider = URLDataProvider()
    private var myBoatBookinData : MyBoatsBookingModel?
    var cartTotalAmount = 0.0
    var packageTotalAmount = 0.0
    var bookingID = ""
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.booking.rawValue, bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        tblVIew.register(cellType: PaymentFirstSectionCell.self)
        tblVIew.estimatedRowHeight = 62
        tblVIew.rowHeight = UITableView.automaticDimension
        tblVIew.reloadData()
        self.getBookingDetail()
        
    }
    
    func getBookingDetail(){
        let requestBody:[String: Any] = ["id":id ?? 0]
        urlProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/boat-booking-detail")!, httpMethod: .post, requestBody: requestBody.percentEncoded(), resultType: BaseResponse<MyBoatsBookingModel>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                self.myBoatBookinData = result?.data
                DispatchQueue.main.async {
                    self.tblVIew.reloadData()
                    self.bookingID = "\(self.myBoatBookinData?.id ?? 0)"
                    self.bookinDate.text = self.myBoatBookinData?.start?.servertoShortDate() ?? ""
                    self.bookingTime.text = (self.myBoatBookinData?.start ?? "").servertoShortTime() + " to " + (self.myBoatBookinData?.end ?? "").servertoShortTime()
                    self.boatName.text = self.myBoatBookinData?.name
                    self.boatImage.setImageUsingKF(string: self.myBoatBookinData?.image ?? "", placeholder: PlaceHolderImages.homelaceHolder)
                    self.pickupadrsLabel.text = self.myBoatBookinData?.pickup_address ?? ""
                    self.totalAmountLabel.text = (self.myBoatBookinData?.grand_total ?? "") + " KWD"
                    self.cartAmountLabel.text = self.myBoatBookinData?.coupon_amount != nil ? "-" + (self.myBoatBookinData?.coupon_amount ?? "") + " KWD" : "0.0 KWD"
//                    if self.myBoatBookinData?.package_name == "" && self.myBoatBookinData?.product?.count ?? 0 == 0{
//                        self.totalAmountLabel.text = "\(Double(self.myBoatBookinData?.total ?? "0.0") ?? 0.0)"
//                    }else if self.myBoatBookinData?.package_name == "" && self.myBoatBookinData?.product?.count ?? 0 != 0{
//                        for i in self.myBoatBookinData!.product!{
//                            self.cartTotalAmount = self.cartTotalAmount + (i.grand_total?.double)!
//                        }
//                        self.totalAmountLabel.text = "\((Double(self.myBoatBookinData?.total ?? "0.0") ?? 0.0) + self.cartTotalAmount)"
//                    }else if self.myBoatBookinData?.package_name != "" && self.myBoatBookinData?.product?.count ?? 0 == 0{
//                        self.packageTotalAmount = self.packageTotalAmount + (self.myBoatBookinData!.package_price?.double)!
//                        self.totalAmountLabel.text = "\((Double(self.myBoatBookinData?.total ?? "0.0") ?? 0.0) + self.packageTotalAmount)"
//                    }
//                    else{
//                        self.packageTotalAmount = self.packageTotalAmount + (self.myBoatBookinData!.package_price?.double)!
//                        for i in self.myBoatBookinData!.product!{
//                            self.cartTotalAmount = self.cartTotalAmount + (i.grand_total?.double)!
//                        }
//                        self.totalAmountLabel.text = "\((Double(self.myBoatBookinData?.total ?? "0.0") ?? 0.0) + self.packageTotalAmount + self.cartTotalAmount)"
//                    }
                    
                }
            }
        }
    }
        
    @IBAction func rateNowTapped(_ sender: Any) {
        let vc = AddReviewVC.instantiate()
        vc.bookingID = self.bookingID
        self.present(vc, animated: true)
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        self.poptoViewController()
    }
    
}

extension BookingDetailVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.myBoatBookinData?.package_name == "" && self.myBoatBookinData?.product?.count ?? 0 == 0){
            return 1
        }else if self.myBoatBookinData?.package_name  != "" &&  self.myBoatBookinData?.product?.count ?? 0 == 0{
            return 2
        }else if (self.myBoatBookinData?.package_name != "" && self.myBoatBookinData?.product?.count ?? 0 != 0){
            return 2 + (self.myBoatBookinData?.product?.count ?? 0)
        }else{
            return 1 + (self.myBoatBookinData?.product?.count ?? 0)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell: PaymentFirstSectionCell = tableView.dequeueReusableCell(for: indexPath)
        aCell.selectionStyle = .none
        if indexPath.row == 0{
            aCell.lblProduct.text = self.myBoatBookinData?.name ?? ""
            aCell.lblPrice.text = self.myBoatBookinData?.total ?? ""
        }else {
            if self.myBoatBookinData?.package_name == ""{
                aCell.lblProduct.text = self.myBoatBookinData?.product?[indexPath.row-1].name ?? ""
                aCell.lblPrice.text = self.myBoatBookinData?.product?[indexPath.row-1].grand_total ?? ""
            }else{
                if indexPath.item == 1{
                    aCell.lblProduct.text = self.myBoatBookinData?.package_name ?? ""
                    aCell.lblPrice.text = self.myBoatBookinData?.package_price ?? ""
                }else{
                    aCell.lblProduct.text = self.myBoatBookinData?.product?[indexPath.row-2].name ?? ""
                    aCell.lblPrice.text = self.myBoatBookinData?.product?[indexPath.row-2].grand_total ?? ""
                }
            }
        }
        return aCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        Utility.delay(0) {
            self.tblHeightConstraint.constant = self.tblVIew.contentSize.height
        }
    }
    
    
}
