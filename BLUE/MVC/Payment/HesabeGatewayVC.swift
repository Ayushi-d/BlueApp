//
//  HesabeGatewayVC.swift
//  HesabeSwiftDemo
//
//  Created by Mohammed Salman on 29/03/20.
//  Copyright © 2020 Mohammed Salman. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class HesabeGatewayVC: UIViewController {
    
    weak var delegate: HesabeGatewayVCDelegate?
    private var AES = HesabeCrypt()
    
    private var headers: HTTPHeaders {
        return ["accessCode": ACCESS_CODE]
    }
    
    /// The view to load the payment gateway
    var webView: WKWebView!
    
    /// The property stores the data to be sent while requesting payment token
    /// for eg - var paymentRequest = PaymentRequest(code: "1351719857300", responseUrl: "http://api.hesbstaging.com", failureUrl: "http://api.hesbstaging.com")
    var paymentRequest: PaymentRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkout(paymentRequest: paymentRequest!)
    }
}

// MARK: - Function
extension HesabeGatewayVC {
    
    /// Create request for Payment Token
    func checkout(paymentRequest: PaymentRequest) {
        let paymentRequestJson = try! JSONEncoder().encode(paymentRequest)
        guard let paymentRequestEncrypted = AES?.encrypt(data: paymentRequestJson) else { return }
        let parameters = ["data": paymentRequestEncrypted]
        
        AF.request("https://sandbox.hesabe.com/checkout", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { response in
            switch response.result {
            case .success:
                print(response.value)
                guard let encryptedResponse = response.value else { return }
                self.checkoutResponse(response: encryptedResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Update Payment Token response
    func checkoutResponse(response encryptedResponse: String) {
        let decryptedResponse = AES?.decrypt(data: encryptedResponse)
        guard let responseJson = decryptedResponse?.data(using: .utf8) else { return }
        let result = try? JSONDecoder().decode(PaymentToken.self, from: responseJson)
        if result?.code == 200, let token = result?.response.data {
            self.redirectToPayment(with: token)
        }
    }
    
    /// Redirect to payment gateway to complete the process
    func redirectToPayment(with token: String) {
        let url = PAYMENT_URL + token
        let request = URLRequest(url: URL(string: url)!)
        self.webView.load(request);
    }
    
}

// MARK: - WKWebView
extension HesabeGatewayVC: WKNavigationDelegate, WKUIDelegate {
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view = webView
    }
    
    /**
     The gateway URL are handled here. On load of every new url in gateway, the method is being called.
     The `decisionHandler()` allows the method to proceed further or stop processing.
     Here, If the response URL is being called, the process is being stopped to extract the data from that url and proceed to update response.
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        /// Process the response after the transaction is complete. To use this method, make sure your SuccessUrl or FailureUrl points to this method in which you'll receive a "data" paramas a GET request. Then you can process it accordingly.
        if url.absoluteString.contains("\(RESPONSE_URL)/?data") || url.absoluteString.contains("\(FAILURE_URL)/?data") {
            decisionHandler(.cancel)
            let urlComponents = url.absoluteString.components(separatedBy: "=")
            let encryptedResponse = urlComponents[1]
            self.paymentResponse(response: encryptedResponse)
        } else {
            print(url)
            decisionHandler(.allow)
        }
    }
    
    /// Updates Payment response post completion
    func paymentResponse(response encryptedResponse: String) {
        let decryptedResponse = AES?.decrypt(data: encryptedResponse)
        guard let responseJson = decryptedResponse?.data(using: .utf8) else { return }
        var paymentResponse = try? JSONDecoder().decode(PaymentResponse.self, from: responseJson)
        if (paymentResponse == nil ) {
            let newResponseString = decryptedResponse?.components(separatedBy: "}}").first?.appending("}}")
            guard let responseJson = newResponseString?.data(using: .utf8) else { return }
            paymentResponse = try? JSONDecoder().decode(PaymentResponse.self, from: responseJson)
        }
        self.dismiss(animated: true) {
            self.delegate?.paymentResponse(response: paymentResponse!)
        }
    }
}

// MARK: - Protocol and Delegate
protocol HesabeGatewayVCDelegate: class {
    func paymentResponse(response: PaymentResponse)
}

extension RestaurantPaymentVC: HesabeGatewayVCDelegate {
    func paymentResponse(response paymentResponse: PaymentResponse) {
        self.hesabeResponse(paymentResponse: paymentResponse)
    }
}
