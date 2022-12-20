//
//  OTPVC.swift
//  BLUE
//
//

import UIKit
import OTPFieldView

class OTPVC: UIViewController,StoryboardSceneBased, OTPFieldViewDelegate {
    
    
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)


    @IBOutlet weak var otpField: OTPFieldView!
    var email = ""
    var otpString = ""
    var hasEnteredOTP = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOtpView()
    }
    
    
    func setupOtpView(){
            self.otpField.fieldsCount = 6
            self.otpField.fieldBorderWidth = 2
            self.otpField.defaultBorderColor = UIColor.black
            self.otpField.filledBorderColor = UIColor.init(named: "ButtonColor")!
            self.otpField.cursorColor = UIColor.red
            self.otpField.displayType = .underlinedBottom
            self.otpField.fieldSize = 40
            self.otpField.separatorSpace = 8
            self.otpField.shouldAllowIntermediateEditing = false
            self.otpField.delegate = self
            self.otpField.initializeUI()
        }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        otpString = otp
        print(otp)
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        hasEnteredOTP = hasEnteredAll
        print("Has entered all OTP? \(hasEnteredOTP)")
        return true
    }
    

   
    @IBAction func submitTapped(_ sender: Any) {
        if hasEnteredOTP{
            let vc = NewPassVC.instantiate()
            vc.email = self.email
            vc.otp = otpString
            self.pushVC(controller: vc)
        }else{
            AlertMesage.show(.error, message: "Please Enter Valid OTP")
        }
    }
    
}
