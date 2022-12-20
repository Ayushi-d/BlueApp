//
//  GoogleLogin+Manager.swift
//  Blue
//
//  Created by Bhikhu on 10/09/20.
//  Copyright © 2020 Bhikhu Infotech Ltd. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase


class GoogleManager: NSObject {
    
    /// Shared object of the UserManager class
    static let shared: GoogleManager = GoogleManager()
    
    /// Closure to be executed when a request has completed.
    internal typealias Data = Result<SocialUser, Error>
    internal typealias Callback = ((Data) -> Void)
    
    private var complitionHandler: Callback?
    
    private override init() {
        
        super.init()
        
        // Initialize sign-in∫
        let serverClientID = UserManager.obfuscator.reveal(key: AppKey.ServerClientID)
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().serverClientID = serverClientID
        GIDSignIn.sharedInstance().scopes =  GoogleScope.arrScope
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    deinit {
        Logger.log("deinit")
    }
    
    public func signIn(from controller: UIViewController, completion: @escaping Callback) {
        
        self.complitionHandler = completion
        
        // Check if there are any previous sign in available or not!
        if GIDSignIn.sharedInstance().hasPreviousSignIn() {
            // ⛔️ SignOut from the previous session
            logout()
        }
        
        // Set presentation controller.
        GIDSignIn.sharedInstance().presentingViewController = controller
            
        // Sign In to Google
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    public func logout() {
        GIDSignIn.sharedInstance().signOut()
    }
    
}

extension GoogleManager: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            complitionHandler?(.failure(error))
            return
        }
        
        // Perform any operations on signed in user here.
        complitionHandler?(.success(SocialUser(user: user)))
        
//        guard let authentication = user.authentication else { return }
        
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
        // ...
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        
        complitionHandler?(.failure(error))
        
    }
    
}


