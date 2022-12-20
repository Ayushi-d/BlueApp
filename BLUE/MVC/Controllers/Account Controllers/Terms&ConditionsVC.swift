//
//  Terms&ConditionsVC.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 27/09/22.
//

import UIKit
import WebKit

class Terms_ConditionsVC: UIViewController , StoryboardSceneBased {
    
    /// Storyboard  variable
    static let sceneStoryboard = UIStoryboard(name: StoryboardName.account.rawValue, bundle: nil)

    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var termsView: UIView!
    var isFrom = ""
    @IBOutlet weak var webKitView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFrom == "Terms"{
            self.navTitle.text = "Terms & Conditions"
            getTermsApi()
        }else{
            self.navTitle.text = "Refund Policy"
            getRefundPolicy()
        }
    }
    
    //private func
    private var termsVM : TermsVM{
        return TermsVM()
    }
    
    //termsDiscription
    private var termsDiscription = ""
    //get termsApi
    private func getTermsApi(){
        termsVM.getTerms { success, response in
            if success{
                self.termsDiscription = response?.data?.description ?? "Terms and conditions"
                self.webKitView.loadHTMLString(self.termsDiscription, baseURL: nil)
            }
        }
    }
    
    private func getRefundPolicy(){
        termsVM.getRefundPolicy { success , response in
            if success{
                self.termsDiscription = response?.data?.description ?? "Terms and conditions"
                self.webKitView.loadHTMLString(self.termsDiscription, baseURL: nil)
            }
        }
    }
    
    //load webview for terms
    private func setTermsData(){
        
    }

   

}
