//
//  GoogleUser.swift
//  Blue
//
//  Created by Bhikhu on 10/09/20.
//  Copyright © 2020 Bhikhu Infotech Ltd. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase


public class SocialUser: NSObject {

    public private(set) var socialID: String? // Actual Social Media Id of the User.
    public private(set) var authCode: String?
    public private(set) var idToken: String?
    public private(set) var firstName: String?
    public private(set) var fullName: String?
    public private(set) var country: String?
    public private(set) var lastName: String?
    public private(set) var email: String?
    public private(set) var imageURL: URL?
    public private(set) var type: RegistationType = .facebook

    internal convenience init(facebookUser: [String: Any]) {
        self.init()

        self.socialID = facebookUser["id"] as? String
        self.idToken = ""
        self.firstName = facebookUser["first_name"] as? String
        self.fullName = facebookUser["name"] as? String
        self.lastName = facebookUser["last_name"] as? String
        self.email = facebookUser["email"] as? String
        self.type = .facebook
        
        if let  picture = facebookUser["picture"] as? [String: Any],  let data = picture["data"] as? [String: Any], let  url = data["url"] as? String {
            self.imageURL = URL(string: url)
        }
    }

    internal convenience init(appleUser: [String: String?]) {
        self.init()

        self.socialID = appleUser["userID"] as? String
        self.idToken = appleUser["identityToken"] as? String
        self.firstName = appleUser["givenName"] as? String
        self.fullName = appleUser["name"] as? String
        self.lastName = appleUser["familyName"] as? String
        self.email = appleUser["email"] as? String
        self.type = .apple
    }

    internal convenience init(linkedInUser: LinkedInUserInfo) {
        self.init()

        self.socialID = linkedInUser.linkedInId
        self.idToken = linkedInUser.linkedInAccessToken
        self.firstName = linkedInUser.linkedInFirstName
        self.lastName = linkedInUser.linkedInLastName
        self.fullName = "\(self.firstName ?? "Someone") \(self.lastName ?? "")"
        self.email = linkedInUser.linkedInEmail
        self.type = .linkedin
        self.imageURL =  URL(string: linkedInUser.linkedInProfilePicURL)
    }
    
    
    /// Initialize from user item.
     ///
     /// - Parameter user: Google User
     internal convenience init(user: GIDGoogleUser) {
         self.init()
            self.authCode = user.serverAuthCode
         self.socialID = user.userID                  // For client-side use only! // 115929766662222295564
         self.idToken = user.authentication.idToken // Safe to send to the server
         self.firstName = user.profile.name
         self.fullName = user.profile.givenName
         self.lastName = user.profile.familyName
         self.email = user.profile.email
         self.imageURL = user.profile.imageURL(withDimension: 512)
         
         
     }
}
