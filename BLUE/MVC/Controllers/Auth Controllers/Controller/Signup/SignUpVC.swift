//
//  SignUpVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 22/09/22.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confrmPasswordTextField: UITextField!
    @IBOutlet weak var civilIDTextField: UITextField!

    @IBOutlet weak var viewfirstNameTextField: UIView!
    @IBOutlet weak var viewlastnameTextField: UIView!
    @IBOutlet weak var viewphoneNoTextField: UIView!
    @IBOutlet weak var viewemailTextField: UIView!
    @IBOutlet weak var viewpasswordTextField: UIView!
    @IBOutlet weak var viewconfrmPasswordTextField: UIView!
    @IBOutlet weak var viewcivilIDTextField: UIView!
    
    // MARK: Variable
    private lazy var authVM: AuthVM = {
        return AuthVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        if validateData() {
            authVM.callWSRegister {
                self.poptoViewController()
            }
        }
    }
    @IBAction func signIntapped(_ sender: UIButton) {
        self.poptoViewController()
    }
    
}

/// Validate Value
/// - Returns: Bool

extension SignUpVC {
    
    /// Validate Value
    /// - Returns: Bool
    private func validateData() -> Bool {
        if (firstNameTextField.text ?? "").isBlank{
            viewfirstNameTextField.shake()
            AlertMesage.show(.error, message: Localizable.validation.fisrtaname)
            return false

        } else if (lastnameTextField.text ?? "").isBlank{
            viewlastnameTextField.shake()
            AlertMesage.show(.error, message: Localizable.validation.lastName)
            return false
       
        } else if (phoneNoTextField.text ?? "").isBlank{
            viewphoneNoTextField.shake()
            AlertMesage.show(.error, message: Localizable.validation.number)
            return false
        
        } else if (emailTextField.text ?? "").isBlank{
            viewemailTextField.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
       
        } else if !(emailTextField.text ?? "").isEmail{
            viewemailTextField.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
       
        } else if  (passwordTextField.text ?? "").isBlank {
            viewpasswordTextField.shake()
            AlertMesage.show(.error, message: Localizable.validation.password)
            return false
        } else if  (confrmPasswordTextField.text ?? "").isBlank {
            viewconfrmPasswordTextField.shake()
            AlertMesage.show(.error, message: Localizable.validation.cpassword)
            return false
        } else if  (confrmPasswordTextField.text ?? "") !=  (passwordTextField.text ?? "") {
            viewpasswordTextField.shake()
            viewconfrmPasswordTextField.shake()
            AlertMesage.show(.error, message: Localizable.validation.passmatch)
            return false
        }  else if  (civilIDTextField.text ?? "").isBlank{
            viewcivilIDTextField.shake()
            AlertMesage.show(.error, message: Localizable.validation.civilID)
            return false
        }
        authVM.saveSignupData(first_name: firstNameTextField.text ?? "", last_name: lastnameTextField.text ?? "", phone_no: phoneNoTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", civil_id: civilIDTextField.text ?? "", fcm_token: UserDefaults.standard.value(forKey: "fcmToken") as? String ?? "23812737312")
        return true
    }
}
