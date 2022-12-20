//
//  MyBookingVC.swift
//  BLUE
//
//  Created by Bhikhu on 15/10/22.
//

import UIKit
struct MyBooking {
    let title: String
    let bookingID:  String
    let price: String
}


class MyBookingVC: UIViewController, StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.booking.rawValue, bundle: nil)
    
    @IBOutlet weak var titleLabel: AppBaseLabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noBookingLabel: UILabel!
    
    var isFrom = ""
    var arrMyBooking = [MyBooking]()
    let urlProvider = URLDataProvider()
    private lazy var boatVM: BoatViewModel = {
        return BoatViewModel()
    }()
    //boatdata
    private var objMyBoatData = [MyBoatData]()
    private var myBoatBookinData = [MyBoatsBookingModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
       
    }
    
    //MARK: - set title
    func setTitle(){
        if isFrom == "myBooking"{
            titleLabel.text = "My Booking"
            getMyBoatBookingsAPI()
        }else{
            titleLabel.text = "My Boats"
            getMyBoatApi()
        }
    }
    
    // MARK: - Private Methods
    private func configureOnViewDidLoad() {
        //
        
        setTitle()
        //
        let obj1 = MyBooking(title: "Catamaran Boats", bookingID: "Booking id : 1234569", price: "4.500 KWD ")
        let obj2 = MyBooking(title: "Catamaran Boats", bookingID: "Booking id : 1234569", price: "4.500 KWD ")
        let obj3 = MyBooking(title: "Catamaran Boats", bookingID: "Booking id : 1234569", price: "4.500 KWD ")
        arrMyBooking.append(obj1)
        arrMyBooking.append(obj2)
        arrMyBooking.append(obj3)
        tblView.register(cellType: MyBookingCell.self)
        tblView.estimatedRowHeight = 142
        tblView.rowHeight = UITableView.automaticDimension
    }
    //View model
   
    private func getMyBoatApi(){
        boatVM.saveMyBoatData(page: 1)
        boatVM.myBoats { [self] success in
            if success{
                objMyBoatData = (boatVM.objMyBoatModel?.data)!
                self.noBookingLabel.isHidden = self.objMyBoatData.count == 0 ? false : true
                tblView.reloadData()
            }
        }
    }
    
    private func getMyBoatBookingsAPI(){
        urlProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/boat-booking-list")!, httpMethod: .get, requestBody: nil, resultType: BaseResponse<[MyBoatsBookingModel]>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                self.myBoatBookinData = result?.data ?? []
                DispatchQueue.main.async {
                    self.noBookingLabel.isHidden = self.myBoatBookinData.count == 0 ? false : true
                    self.tblView.reloadData()
                }
            }
        }
    }
}

// MARK: UITableViewDelegate
extension MyBookingVC :UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if isFrom == "myBooking"{
            return myBoatBookinData.count
        }else{
            return objMyBoatData.count
        }
        
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell: MyBookingCell = tableView.dequeueReusableCell(for: indexPath)
         if isFrom == "myBooking"{
             aCell.configCell(with: myBoatBookinData[indexPath.row])
         }else{
             aCell.configCellForMyBoat(with: objMyBoatData[indexPath.row])
         }
        
        return aCell
         
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFrom == "myBooking"{
            let vc = BookingDetailVC.instantiate(fromStoryboard: .booking)
            vc.id = myBoatBookinData[indexPath.row].id ?? 0
            self.navigationController?.isHeroEnabled = true
            self.navigationController?.heroNavigationAnimationType = .zoom
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = BoatDetailVC.instantiate(fromStoryboard: .home)
            vc.isFrom = "myBoat"
            vc.id = objMyBoatData[indexPath.row].id ?? 0
            print(objMyBoatData[indexPath.row].id ?? 0)
            self.navigationController?.isHeroEnabled = true
            self.navigationController?.heroNavigationAnimationType = .zoom
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
