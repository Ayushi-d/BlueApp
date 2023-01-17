//
//  AccountVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 26/09/22.
//

import UIKit

class AccountVC: UIViewController, accountDelegate {
  
    

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var accountTableView: UITableView!{
        didSet{
            accountTableView.register(UINib(nibName: "AccountCell", bundle: nil), forCellReuseIdentifier: "AccountCell")
        }
    }
    
    let urlDataProvider = URLDataProvider()
    var notificationStatus: Bool?
    let accountArray = [AccountModel.init(accountLabel: "Edit Profile", accountImage: UIImage.init(named: "ic_editProfile")),AccountModel.init(accountLabel: "My Bookings", accountImage: UIImage.init(named: "ic_calander")),AccountModel.init(accountLabel: "Terms & Condition", accountImage: UIImage.init(named: "ic_terms&Conditions")),AccountModel.init(accountLabel: "Contact Us", accountImage: UIImage.init(named: "ic_call")),AccountModel.init(accountLabel: "Refund Policy", accountImage: UIImage.init(named: "ic_refund")),AccountModel.init(accountLabel: "Push Notification", accountImage: UIImage.init(named: "ic_notificationBlue")),AccountModel.init(accountLabel: "Change Password", accountImage: UIImage.init(named: "ic_lock")),AccountModel.init(accountLabel: "Logout", accountImage: UIImage.init(named: "ic_logout"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserDetails()
    }
    
    // MARK: Private Methods
    private func configureOnViewDidLoad() {
        if let user = UserManager.shared.current {
         //   userName.text = user.fullname
            userEmail.text = user.email
        }
       
    }
    
    func getUserDetails(){
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/user-detail")!, httpMethod: .get, requestBody: nil, resultType: BaseResponse<UserVerifyModel>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    self.notificationStatus = result?.data?.notification_status ?? true
                    self.userName.text = (result?.data?.first_name ?? "") + " " + (result?.data?.last_name ?? "")
                    self.accountTableView.reloadData()
                }
            }
        }
    }
    
    func updateNotificationStatus(isOn: Bool){
        let requestBody: [String: Any] = ["notification_status": isOn ? 1 : 0]
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/notification-status-update")!, httpMethod: .post, requestBody: requestBody.percentEncoded()) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    self.getUserDetails()
                }
            }
        }
    }
    
    func logoutAPI(){
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/logout")!, httpMethod: .post, requestBody: nil) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    UserManager.shared.removeUser()
                    Utility.setRootScreen(isAnimation: true)
                }
            }
        }
    }
    
    func notificationSwitch(isON: Bool) {
      updateNotificationStatus(isOn: isON)
    }
    
}

extension AccountVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = accountTableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as? AccountCell else {return UITableViewCell() }
        switch indexPath.row{
        case 5:
            cell.delegate = self
            cell.accountImage.image = accountArray[indexPath.row].accountImage
            cell.accountLabel.text = accountArray[indexPath.row].accountLabel
            cell.switchButton.isHidden = false
            cell.accountBtn.isHidden =  true
            cell.switchButton.isOn = notificationStatus ?? true ? true : false
        default:
            cell.accountImage.image = accountArray[indexPath.row].accountImage
            cell.accountLabel.text = accountArray[indexPath.row].accountLabel
            cell.switchButton.isHidden =  true
            cell.accountBtn.isHidden =  false
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch accountArray[indexPath.row].accountLabel{
        case "My Bookings":
            self.pushToMyBookingVC(from: "myBooking")
        case "Push Notification":
            break
            //self.pushVC(controller: NotificationVC.instantiate())
        case "My Parking":
            let parking = MyParkingVC.instantiate()
            parking.isFromSetting = true
            self.pushVC(controller: parking)
        case "Terms & Condition":
            let vc = Terms_ConditionsVC.instantiate()
            vc.isFrom = "Terms"
            self.pushVC(controller: vc)
        case "Refund Policy":
            let vc = Terms_ConditionsVC.instantiate()
            vc.isFrom = "Policy"
            self.pushVC(controller: vc)
        case "Contact Us":
            self.pushVC(controller: ContactUsVC.instantiate())
        case "Edit Profile":
            self.pushVC(controller: EditProfileVC.instantiate())
        case "Change Password":
            self.pushVC(controller: ChangePassVC.instantiate())
        case "Logout":
            
//            let vc = AddBoatsVC.instantiate()
//            self.pushVC(controller: vc)
                        logoutConfirmation()

        default:
            break
        }
    }
    
    /// Logout confrimation
     func logoutConfirmation() {
         UIAlertController.showAlert(controller: self, title: Localizable.CaptainPayment.alert, message: Localizable.Account.logoutmesssgae, style: .alert, cancelButton: Localizable.Buttons.no, distrutiveButton: Localizable.Buttons.yes, otherButtons: nil) { (_, btnStr) in
            if btnStr == Localizable.Buttons.yes {
                self.logoutAPI()
            }
        }
    }
    
    func pushToMyBookingVC(from: String){
        let vc = MyBookingVC.instantiate(fromStoryboard: .booking)
        vc.isFrom = from
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoomOut
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
