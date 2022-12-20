//
//  ForgotPassVC.swift
//  BLUE
//
//

import UIKit

class ForgotPassVC: UIViewController, StoryboardSceneBased {
    
    let urlDataProvider = URLDataProvider()

    static let sceneStoryboard = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)

    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
   
    
    func getOTPAPI(){
        var param: [String: Any] = [:]
        param[API.Key.email]  = self.emailField.text!
        let service = Service.forgotPassword(param: param)
        Network.request(service) { (aResponse) in
            guard let success = aResponse?["success"].boolValue else {return}
            if success{
                let vc = OTPVC.instantiate()
                vc.email = self.emailField.text!
                self.pushVC(controller: vc)
            }else{
                guard let message = aResponse?["message"].string as? String else {return}
                AlertMesage.show(.error, message: message)
            }
            
        }
    }
    

    @IBAction func getOtpTapped(_ sender: UIButton) {
        if validateData(){
            self.getOTPAPI()
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.poptoViewController()
    }
}

extension ForgotPassVC{
    
    private func validateData() -> Bool {
        if (emailField.text ?? "").isBlank{
            // 🚨 Blank Email
            emailField.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
        }else if !(emailField.text ?? "").isEmail{
            // 🚨 Blank Not Valid email
            emailField.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
        }
         
        // ✅
        return true
    }
    
}
