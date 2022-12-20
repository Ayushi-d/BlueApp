//
//  EditProfileVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 27/09/22.
//

import UIKit

class EditProfileVC: UIViewController, StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.account.rawValue, bundle: nil)

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNoField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var civilIDField: UITextField!

    @IBOutlet weak var viewfirstNameField: UIView!
    @IBOutlet weak var viewlastNameField: UIView!
    @IBOutlet weak var viewphoneNoField: UIView!
    @IBOutlet weak var viewemailField: UIView!
    @IBOutlet weak var viewcivilIDField: UIView!

    // MARK: Variable
    var isFrom = ""
    private lazy var authVM: AuthVM = {
        return AuthVM()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserData()
    }
    
    func setUserData(){
       if let aUser = UserManager.shared.current {
           firstNameField.text  = aUser.first_name
            lastNameField.text  = aUser.last_name
            phoneNoField.text  = aUser.phone_no
            emailField.text  = aUser.email
            civilIDField.text  = aUser.civil_id
        }
    }

    // MARK: IB Actions
    @IBAction func submitBtnTapped(_ sender: Any) {
        if validateData() {
            authVM.callWSUpdateProfile(isSocial: isFrom == "Socail" ? true : false) {
                if self.isFrom == "Socail"{
                    let vc = BottomBarController.instantiate()
                    self.pushVC(controller: vc)
                }else{
                    self.poptoViewController()
                }
            }
        }
    }
}

/// Validate Value
/// - Returns: Bool

extension EditProfileVC {
    
    /// Validate Value
    /// - Returns: Bool
    private func validateData() -> Bool {
        if (firstNameField.text ?? "").isBlank{
            viewfirstNameField.shake()
            AlertMesage.show(.error, message: Localizable.validation.fisrtaname)
            return false

        } else if (lastNameField.text ?? "").isBlank{
            viewlastNameField.shake()
            AlertMesage.show(.error, message: Localizable.validation.lastName)
            return false
       
        } else if (phoneNoField.text ?? "").isBlank{
            viewphoneNoField.shake()
            AlertMesage.show(.error, message: Localizable.validation.number)
            return false
        
        } else if (emailField.text ?? "").isBlank{
            viewemailField.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
       
        } else if !(emailField.text ?? "").isEmail{
            viewemailField.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
       
        } else if  (civilIDField.text ?? "").isBlank{
            viewcivilIDField.shake()
            AlertMesage.show(.error, message: Localizable.validation.civilID)
            return false
        }
        authVM.saveSignupData(first_name: firstNameField.text ?? "", last_name: lastNameField.text ?? "", phone_no: phoneNoField.text ?? "", email: emailField.text ?? "", password:  "", civil_id: civilIDField.text ?? "", fcm_token: UserDefaults.standard.value(forKey: "fcmToken") as? String ?? "23812737312")
        return true
    }
}
