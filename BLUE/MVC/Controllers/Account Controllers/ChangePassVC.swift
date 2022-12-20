//
//  ChangePassVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 27/09/22.
//

import UIKit

class ChangePassVC: UIViewController, StoryboardSceneBased {
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.account.rawValue, bundle: nil)

    @IBOutlet weak var currentPassField: UITextField!
    @IBOutlet weak var newPassField: UITextField!
    @IBOutlet weak var confrmPassField: UITextField!

    // MARK: Variable
    private lazy var authVM: AuthVM = {
        return AuthVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    /// Button Action method for Submit Button
    /// - Parameter sender: Object of the Button
    @IBAction func submitBtnTapped(_ sender: Any) {
        if validateData() {
            authVM.callWSChangePassword { // Change Password API
                self.poptoViewController()
            }
        }
    }
    
}

/// Validate Value
/// - Returns: Bool

extension ChangePassVC {
    
    /// Validate Value
    /// - Returns: Bool
    private func validateData() -> Bool {
        if (currentPassField.text ?? "").isBlank{
            // 🚨 current PassField
            currentPassField.shake()
            AlertMesage.show(.error, message: Localizable.validation.currentPassord)
            return false
        } else if (newPassField.text ?? "").isBlank{
            // 🚨 Blank Not Valid new password
            newPassField.shake()
            AlertMesage.show(.error, message: Localizable.validation.newPassord)
            return false
        } else if  (confrmPassField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            confrmPassField.shake()
            AlertMesage.show(.error, message: Localizable.validation.confirmPassord)
            return false
        } else if  (newPassField.text ?? "") != (confrmPassField.text ?? ""){
            // 🚨 Blank Phone number
            confrmPassField.shake()
            newPassField.shake()
            AlertMesage.show(.error, message: Localizable.validation.newpasswordSame)
            return false
        }
        authVM.saveChnagePasswordData(old_password: (currentPassField.text ?? ""), new_password: (newPassField.text ?? ""), confirm_password: (confrmPassField.text ?? ""))
        // ✅
        return true
    }
}

