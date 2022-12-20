//
//  LoginVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 22/09/22.
//

import UIKit
import Hero
import AuthenticationServices
import GoogleSignIn

class LoginVC: UIViewController, StoryboardSceneBased {
    
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)

    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var appleVIew: UIView!
    @IBOutlet weak var googleView: UIView!
    let urlDataProvider = URLDataProvider()
    
    internal typealias Data = Result<SocialUser, Error>
    internal typealias Callback = ((Data) -> Void)
    
    private var completionHandler: Callback?
    
    // MARK: Variable
    private lazy var authVM: AuthVM = {
        return AuthVM()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @IBAction func eyeButton_tapped(_ sender: UIButton) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // 📡 Call WS
        

        if validateData() {
            callWSToSignIn()
        }
//                navigateToAddBoat()
    }
    
    @IBAction func ownsABoattapped(_ sender: UIButton) {
        if validateData() {
            callWSToSignInForAddBoat()
        }
    }
    
    @IBAction func signupTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.isHeroEnabled = true
        self.navigationController?.heroNavigationAnimationType = .zoom
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func googleTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func appletapped(_ sender: UIButton) {
        
        let appledetails = ASAuthorizationAppleIDProvider()
                let request = appledetails.createRequest()
                request.requestedScopes = [.email , .fullName]
                let controller  = ASAuthorizationController(authorizationRequests: [request])
                controller.delegate = self
                controller.performRequests()
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        let vc = ForgotPassVC.instantiate()
        self.pushVC(controller: vc)
    }
    
    func navigateToAddBoat(){
        let vc =  AddBoatsVC.instantiate()
        self.pushVC(controller: vc)
    }
    
}

/// Validate Value
/// - Returns: Bool

extension LoginVC {
    
    /// Validate Value
    /// - Returns: Bool
    private func validateData() -> Bool {
        if (emailTextField.text ?? "").isBlank{
            // 🚨 Blank Email
            viewEmail.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
        } else if !(emailTextField.text ?? "").isEmail{
            // 🚨 Blank Not Valid email
            viewEmail.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
        } else if  (passwordTextField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            viewPassword.shake()
            AlertMesage.show(.error, message: Localizable.validation.password)
            return false
        }
        
        authVM.saveData(emailPhone: (emailTextField.text ?? ""), password: (passwordTextField.text ?? ""), isPhoneNumber: false, fcmToken: UserDefaults.standard.value(forKey: "fcmToken") as? String ?? "")
        // ✅
        return true
    }
}


// MARK: - Web service call
extension LoginVC {
    /// Sign in API
    /// - Parameter isSocial: Bool
    private func callWSToSignIn(isSocial: Bool = false) {
        authVM.callWSLogin(isSocial: isSocial) {
            guard let aUser = UserManager.shared.current else {
                UDManager.isUserLogin = false
                return
            }
            Utility.setRootScreen(isAnimation: true)
        }
    }
    
    private func callWSToSignInForAddBoat(isSocial: Bool = false) {
        authVM.callWSLogin(isSocial: isSocial) {
            guard let aUser = UserManager.shared.current else {
                UDManager.isUserLogin = false
                return
            }
            self.pushVC(controller: AddBoatsVC.instantiate())
        }
    }
    
    
    private func callWSSocial(){
        authVM.callWSSocialLogin(isSocial: true) {
            guard let aUser = UserManager.shared.current else {
                UDManager.isUserLogin = false
                return
            }
            self.getUserDetails()
        }
    }
    
    
    func getUserDetails(){
        urlDataProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/user-detail")!, httpMethod: .get, requestBody: nil, resultType: BaseResponse<UserVerifyModel>.self) { result, statusCode, isSuccess, error in
            if isSuccess{
                DispatchQueue.main.async {
                    guard let isVerified = result?.data?.isVerified else {return }
                    if isVerified{
                        Utility.setRootScreen(isAnimation: true)
                    }else{
                        UDManager.isUserLogin = false
                        let vc = EditProfileVC.instantiate()
                        vc.isFrom = "Socail"
                        self.pushVC(controller: vc)
                    }
                }
            }
        }
    }
    
   
    
}
// Apple login
extension LoginVC:ASAuthorizationControllerDelegate{
    @available(iOS 13.0, *)
      func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
          print(error.localizedDescription)
      }

      @available(iOS 13.0, *)
      func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
          if let details  = authorization.credential as? ASAuthorizationAppleIDCredential {
              print(details.user)
              authVM.saveSocialData(social_type: "apple", social_id: details.user)
              callWSSocial()
            //  Signin()

          }
      }
}

//Google Login
extension LoginVC: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("faliure",err)
            return
        }
        print(user.userID!,"sdfsafasd")
        completionHandler?(.success(SocialUser(user: user)))
        authVM.saveSocialData(social_type: "google", social_id: user.userID)
        callWSSocial()
    }
    
    
}


