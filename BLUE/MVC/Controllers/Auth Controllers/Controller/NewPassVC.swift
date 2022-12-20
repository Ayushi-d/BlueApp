//
//  NewPassVC.swift
//  BLUE
//
//

import UIKit

class NewPassVC: UIViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
    
    @IBOutlet weak var newPassField: UITextField!
    var email = ""
    var otp = ""
    
    
    @IBOutlet weak var cnfrmPassField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getOTPAPI(){
        var param: [String: Any] = [:]
        param[API.Key.email]  = self.email
        param["token"] = otp
        param[API.Key.password] = self.newPassField.text!
        let service = Service.verifyPin(param: param)
        Network.request(service) { (aResponse) in
            guard let success = aResponse?["success"].boolValue else {return}
            if success{
                guard let message = aResponse?["message"].string as? String else {return}
                AlertMesage.show(.success, message: message)
                Utility.setRootScreen(isAnimation: true)
            }else{
                guard let message = aResponse?["message"].string as? String else {return}
                AlertMesage.show(.error, message: message)
            }
            
        }
    }
    

    @IBAction func submitTapped(_ sender: Any) {
        if validateData(){
            self.getOTPAPI()
        }
    }
}

extension NewPassVC{
    
    private func validateData() -> Bool {
        if (newPassField.text ?? "").isBlank{
            // 🚨 Blank Email
            newPassField.shake()
            AlertMesage.show(.error, message: Localizable.validation.newPassord)
            return false
        }else if (cnfrmPassField.text ?? "").isBlank{
            // 🚨 Blank Not Valid email
            cnfrmPassField.shake()
            AlertMesage.show(.error, message: Localizable.validation.confirmPassord)
            return false
        }
         
        // ✅
        return true
    }
}
