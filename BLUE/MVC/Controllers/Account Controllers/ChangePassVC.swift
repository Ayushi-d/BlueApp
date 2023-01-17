//
//  ChangePassVC.swift
//  BLUE
//
//

import UIKit

class ChangePassVC: UIViewController, StoryboardSceneBased {
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.account.rawValue, bundle: nil)

    @IBOutlet weak var currentPassField: UITextField!
    @IBOutlet weak var newPassField: UITextField!
    @IBOutlet weak var confrmPassField: UITextField!

    @IBOutlet weak var currentEyeIcon: UIButton!
    @IBOutlet weak var newEyeIcon: UIButton!
    @IBOutlet weak var cnfrmEyeIcon: UIButton!
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
    
    @IBAction func currentEyeTapped(_ sender: UIButton) {
        if currentPassField.isSecureTextEntry {
            currentPassField.isSecureTextEntry = false
        } else {
            currentPassField.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func newEyeTapped(_ sender: UIButton) {
        if newPassField.isSecureTextEntry {
            newPassField.isSecureTextEntry = false
        } else {
            newPassField.isSecureTextEntry = true
        }
    }
    
    @IBAction func cnfrmEyetapped(_ sender: UIButton) {
        if confrmPassField.isSecureTextEntry {
            confrmPassField.isSecureTextEntry = false
        } else {
            confrmPassField.isSecureTextEntry = true
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

