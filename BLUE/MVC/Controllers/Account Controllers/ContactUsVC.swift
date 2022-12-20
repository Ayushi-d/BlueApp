//
//  ContactUsVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 27/09/22.
//

import UIKit

class ContactUsVC: UIViewController, StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.account.rawValue, bundle: nil)

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var reviewField: UITextView!
    @IBOutlet weak var emailField: UITextField!
    
    let urlProvider = URLDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewField.layer.borderColor = UIColor.lightGray.cgColor
        reviewField.layer.borderWidth = 1.0
        reviewField.layer.cornerRadius = 10
    }
    

    @IBAction func submitBtnTapped(_ sender: Any) {
        if validateData(){
            contactAPI()
        }
    }
    
    func contactAPI(){
        let requestBody: [String: Any] = ["name":nameField.text!,"answer":reviewField.text!, "email":emailField.text!]
        urlProvider.hitAPI(requestUrl: URL(string: "https://blue.testingjunction.tech/api/contact-us")!, httpMethod: RequestMethod.post, requestBody: requestBody.percentEncoded()) { result, statusCode, isSuccess, error in
            if isSuccess{
                AlertMesage.show(.success, message: result["message"] as? String ?? "Success")
            }else{
                AlertMesage.show(.error, message: result["message"] as? String ?? "error")
            }
        }
    }
}

extension ContactUsVC{
    
    private func validateData() -> Bool {
        if  (nameField.text ?? "").isBlank {
            // 🚨 Blank Phone number
            nameField.shake()
            AlertMesage.show(.error, message: Localizable.validation.fisrtaname)
            return false
        } else if (emailField.text ?? "").isBlank{
            // 🚨 Blank Email
            emailField.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
        } else if !(emailField.text ?? "").isEmail{
            // 🚨 Blank Not Valid email
            emailField.shake()
            AlertMesage.show(.error, message: Localizable.validation.email)
            return false
        }
        else if (reviewField.text ?? "").isBlank{
            reviewField.shake()
            AlertMesage.show(.error, message: Localizable.validation.review)
            return false
        }
        
        return true
    }
}
