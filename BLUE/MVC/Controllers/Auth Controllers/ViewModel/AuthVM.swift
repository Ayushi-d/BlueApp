//
//  AuthVM.swift
//  BLUE
//
//  Created by Bhikhu on 16/10/22.
//

import Foundation
import UIKit

class AuthVM {

    private var email: String!
    private var isPhoneNumber = false
    private var password: String!
    private var fcm_token: String!

    private var first_name: String!
    private var last_name: String!
    private var phone_no: String!
    private var civil_id: String!
    
    private var old_password: String!
    private var new_password: String!
    private var confirm_password: String!
    private var social_id: String!
    private var social_type: String!
    
    private var referralCode: String!
    
    var socialUser: SocialUser?

  
    
    /// Closure to be executed when a request has completed.
    internal typealias Completion = (User?) -> Void


    /// save user details
    /// - Parameters:
    ///   - email: pass email/phone in string
    ///   - password: password description
    public func saveData(emailPhone: String,
                         password: String,
                         isPhoneNumber: Bool,
                         fcmToken: String) {

        self.email = emailPhone
        self.password = password
        self.isPhoneNumber = isPhoneNumber
        self.fcm_token = fcmToken
    }
    ///
    ///
    public func saveSocialData(social_type: String,
                               social_id: String) {

        self.social_type = social_type
        self.social_id = social_id
    }
    /// save user details
    /// - Parameters:
    ///   - email: pass email/phone in string
    ///   - password: password description
    public func saveSignupData(first_name: String,
                               last_name: String,
                               phone_no: String,
                               email: String,
                               password: String,
                               civil_id: String,
                               fcm_token: String) {
        self.email = email
        self.password = password
        self.first_name = first_name
        self.last_name = last_name
        self.phone_no = phone_no
        self.password = password
        self.civil_id = civil_id
        self.fcm_token = fcm_token
    }

    
    /// save user Passworddetails
    /// - Parameters:
    ///   - email: pass email/phone in string
    ///   - password: password description
    public func saveChnagePasswordData(old_password: String,
                                       new_password: String,
                                       confirm_password: String) {
        self.old_password = old_password
        self.new_password = new_password
        self.confirm_password = confirm_password
    }
    
 
    /// save social info
    /// - Parameter socialUser: object of social data
    public func socialLoginData(socialUser: SocialUser) {
        self.socialUser = socialUser
    }
   
    /// password
    /// - Parameter completion: as
    /// - Returns: s
    public func callWSLogin(isSocial: Bool = false, completion: @escaping (() -> Void)) {
        var param: [String: Any] = [:]
         
       
            param[API.Key.email]  = self.email
            param[API.Key.password] = password
            param[API.Key.fcm_token] = fcm_token
        
        let service = Service.login(param: param)
        Network.request(service) { (aResponse) in
            if let aDictData = aResponse?[API.Response.data].dictionary {
                // ✅ Success Data is received from the server.
                
                if let aStrToken = aDictData[API.Response.token]?.string {
                    UserManager.shared.saveAuthToken(aStrToken)
                    print(UserManager.shared.authToken ?? "")
                   }
                // Handle success reponse.
                self.handleSuccess(data: aDictData, completion: completion)
            }
        }
    }
    
    
    /// password
    /// - Parameter completion: as
    /// - Returns: s
    public func callWSRegister(isSocial: Bool = false, completion: @escaping (() -> Void)) {
        var param: [String: Any] = [:]
        param[API.Key.first_name] = self.first_name
        param[API.Key.last_name] = last_name
        param[API.Key.phone_no] = phone_no
        param[API.Key.email] = email
        param[API.Key.password] = password
        param[API.Key.civil_id] = civil_id
        param[API.Key.fcm_token] = fcm_token

        let service = Service.singUp(param: param)
        Network.request(service) { (aResponse) in
            if (aResponse?[API.Response.data].dictionary) != nil {
                // ✅ Success Data is received from the server.
                if let message = aResponse?[API.Response.message].string {
                    AlertMesage.show(.success, message:message )
                }
                // Handle success reponse.
                if aResponse?["success"].bool == true{
                    completion()
                }
            }
        }
    }
    /// Update Profile
    /// - Parameter completion: as
    /// - Returns: s
    public func callWSUpdateProfile(isSocial: Bool, completion: @escaping (() -> Void)) {
        var param: [String: Any] = [:]
        param[API.Key.first_name] = self.first_name
        param[API.Key.last_name] = last_name
        param[API.Key.phone_no] = phone_no
        param[API.Key.email] = email
        param[API.Key.civil_id] = civil_id
        let service =  isSocial ? Service.userUpdateSocail(param: param) : Service.userUpdate(param: param)
        Network.request(service) { (aResponse) in
            if (aResponse?[API.Response.data].dictionary) != nil {
                // ✅ Success Data is received from the server.
                if let message = aResponse?[API.Response.message].string {
                    AlertMesage.show(.success, message:message )
                }
                // Handle success reponse.
                if let aDictData = aResponse?[API.Response.data].dictionary {
                    self.handleSuccess(data: aDictData, completion: completion)
                }
            }
        }
    }
    
    /// password Change
    /// - Parameter completion: as
    /// - Returns: s
    public func callWSChangePassword(isSocial: Bool = false, completion: @escaping (() -> Void)) {
        var param: [String: Any] = [:]
        param[API.Key.old_password] = old_password
        param[API.Key.new_password] = new_password
        param[API.Key.confirm_password] = confirm_password

        let service = Service.changePassword(param: param)
        Network.request(service) { (aResponse) in
            if (aResponse?["success"].boolValue) == true {
                // ✅ Success Data is received from the server.
                if let message = aResponse?[API.Response.message].string {
                    AlertMesage.show(.success, message:message )
                }
                // Handle success reponse.
                completion()
            }
        }
    }
    
    public func callWSSocialLogin(isSocial: Bool = false, completion: @escaping (() -> Void)) {
        var param: [String: Any] = [:]
        param[API.Key.social_type]  = self.social_type
        param[API.Key.social_id] = social_id
        param[API.Key.fcm_token] = fcm_token
        
        let service = Service.socaiLogin(param: param)
        Network.request(service) { (aResponse) in
            if let aDictData = aResponse?[API.Response.data].dictionary {
                // ✅ Success Data is received from the server.
                
                if let aStrToken = aDictData[API.Response.token]?.string {
                    UserManager.shared.saveAuthToken(aStrToken)
                    print(UserManager.shared.authToken ?? "")
                  
                   }
                // Handle success reponse.
                self.handleSuccess(data: aDictData, completion: completion)
            }
        }
    }
    
    /// Handle Auth Sucess
    /// - Parameters:
    ///   - data: Any
    ///   - completion: Void
    private func handleSuccess(data: Any, completion: @escaping (() -> Void)) {

        let aUser = User(object: data)
        UserManager.shared.sync(user: aUser)

        completion()
    }
    

}
