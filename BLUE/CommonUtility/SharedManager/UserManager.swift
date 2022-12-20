// https://www.swiftjectivec.com/nssecurecoding/

import Foundation
import UIKit

class UserManager {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let userData = "encrypted_user_data"
        static let email = "current_user_email"
        static let authToken = "current_user_token"
        static let fcmToken = "fcm_token"
        static let passcode = "current_user_passcode"
        static let deviceAPNSToken = "device_APNS_Token"
        static let deviceID = "device_unique_id"
        static let quickbloxuserData = "encrypted_quickbloxuser_data"
    }

    /// Shared object of the UserManager class
    static let shared: UserManager = UserManager()

    static  let obfuscator = Obfuscator(withSalt: [""])

    
    

    private init() {

        current = nil

        // Get/Create unique device token.
        if let strDeviceID = keychain[SerializationKeys.deviceID] {
            deviceID = strDeviceID
        } else {

            deviceID = UUID().uuidString
            // Store the unique device key in the keychain.
            keychain[SerializationKeys.deviceID] = deviceID

        }

        ///* this  code will user when QB issue resolve
        if UDManager.isUserLogin, let objUser = getUser() {
             // Get auth token

            authToken = getAuthToken()
            fcmToken = getFcmToken()
            current = objUser

        }
         //*/
        
        /// remove this while QB working proper
        if UDManager.isUserLogin, let objUser = getUser() {
            // Get auth token

            authToken = getAuthToken()
            fcmToken = getFcmToken()
            current = objUser
            
        }

    }

    // MARK: - Private Properties

    // MARK: - Public Properties

    /// Return the current logged in user object.
    ///
    ///     UserManager.shared.current
    private(set) var current: User?

    /// Return the current logged in user object.
    ///
    ///     UserManager.shared.authToken
    private(set) var authToken: String?
    
    /// Return the current logged in user object.
    ///
    ///     UserManager.shared.authToken
    private(set) var fcmToken: String?

    /// Device Unique Identifier.
    private(set) var deviceID: String

    /// The default address which will be used to call an API and to also to get home screen data.
//    public var defaultAddress: Address?

    // MARK: - Public Functions

    /// This function will sync the current user data with the existing stored data in the keychain.
    ///
    ///     UserManager.shared.sync(user: OBJECT)
    ///
    /// - Parameter newUser: Object of the new User.
    /// - Returns: `true` if data is stored successfully otherwise `false`
    @discardableResult
    public func sync(user: User) -> Bool {

        // Store the user in the Keychain
        if storeUser(user) {

            // Assign to the local variable
            self.current = nil
            self.current = user
            return true

        }

        return false

    }


    /// This method will store the user's Authentication Token which was received from the server.
    ///
    ///     UserManager.shared.saveAuthToken("YourNewToken")
    ///
    /// - Parameter token: Token which you wanted to store.
    @discardableResult
    public func saveAuthToken(_ token: String) -> Bool {
        //        let user = UserManager.shared.current ?? User(object: [:])
        //        user.authToken = token
        //        UserManager.shared.syncUser(with: user)

        // Store the token locally
        authToken = token

        // Encrypt Auth Token
        guard let strEncodedEncryptedEmail = token.base64Encoded?.base64Encoded else { return false }

        // Store Auth Token in keychain
        keychain[SerializationKeys.authToken] = strEncodedEncryptedEmail

        return true

    }
    
    /// This method will store the user's FCM Token which was received Firebase the server.
    ///
    ///     UserManager.shared.saveAuthToken("YourNewToken")
    ///
    /// - Parameter token: Token which you wanted to store.
    @discardableResult
    public func saveFcmToken(_ token: String) -> Bool {
        //        let user = UserManager.shared.current ?? User(object: [:])
        //        user.authToken = token
        //        UserManager.shared.syncUser(with: user)

        // Store the token locally
        fcmToken = token

        // Encrypt Auth Token
        guard let strEncodedEncryptedEmail = token.base64Encoded?.base64Encoded else { return false }

        // Store Auth Token in keychain
        keychain[SerializationKeys.fcmToken] = strEncodedEncryptedEmail

        return true

    }
    
    
    

    /// This function will remove the existing user data from the keychain.
    ///
    ///     UserManager.shared.removeUser()
    ///
    public func removeUser() {
        UDManager.unreadChatCount = 0
        
        
        UDManager.isUserLogin = false
        
        // Set Notification badge to zero...
        Utility.applicationIconBadgeNumber = 0
        
        removeUserFromKeychain()

        current = nil
        authToken = nil

    }
}

// MARK: - Private Functions

extension UserManager {

    /// This method will remove all the stored cache files for the API responses.
    private func removeAllStoredFilesFromCache() {

//        var strCachePath = cache.cachePath
//        strCachePath = strCachePath.stringByAppendingPathComponent(HanekeGlobals.Cache.OriginalFormatName)
//
//        let arrFiles = try? FILE_MANAGER.contentsOfDirectory(atPath: strCachePath)
//        //        print(arrFiles)
//
//        if let arrFilePaths = arrFiles {
//            for path in arrFilePaths {
//                let fullPath = strCachePath.stringByAppendingPathComponent(path)
//                do {
//                    try FILE_MANAGER.removeItem(atPath: fullPath)
//                    Logger.log("File removing: \(fullPath)")
//                } catch _ {
//                    Logger.log("Error removing file: \(fullPath)")
//                }
//            }
//        }

    }

    /// This function will remove the stored user's data from keychain.
    private func removeUserFromKeychain() {

        // Remove user data
        try? keychain.remove(SerializationKeys.userData)

        // Remove Authentication token
        try? keychain.remove(SerializationKeys.authToken)

    }

    /// This function will remove the stored user's data from keychain.
    private func removeQuicbloxUserFromKeychain() {

        // Remove user data
        try? keychain.remove(SerializationKeys.quickbloxuserData)
    }

    /// This function will used to store the User's Auth Token in the Keychain access.
    ///
    ///     UserManager.storeAuthToken("TOKEN")
    ///
    /// - Parameters:
    ///   - email: Email Address which you want to store in the Keychain.
    ///   - password: Password which you want to store in the Keychain.
    //    private func storeAuthToken(_ token: String?) {
    //
    //        // 1. Encode the Auth Token
    //        guard let strEncodedEmail = token?.trimmed else { return }
    //
    //        // 2. Encrypt Auth Token
    //        guard let strEncodedEncryptedEmail = strEncodedEmail.base64Encoded?.base64Encoded?.base64Encoded else { return }
    //
    //        // Store Auth Token in keychain
    //        keychain[SerializationKeys.authToken] = strEncodedEncryptedEmail
    //
    //    }

    /// This method will get the current user Auth Token which is stored in the KeyChain Access.
    ///
    ///     UserManager.getAuthToken()
    ///
    /// - Returns: Email address which is stored in the Keychain
    private func getAuthToken() -> String? {

        // 1. Get the Encrypted + Encoded Auth Token
        guard let strEncodedToken = keychain[SerializationKeys.authToken] else { return nil }

        // 2. Decrypt the Auth Token
        guard let strAuthToken = strEncodedToken.base64Decoded?.base64Decoded else { return nil }

        return strAuthToken

    }
    
    // This method will get the current user Auth Token which is stored in the KeyChain Access.
    ///
    ///     UserManager.getFCMToken()
    ///
    /// - Returns: Email address which is stored in the Keychain
    private func getFcmToken() -> String? {

        // 1. Get the Encrypted + Encoded Auth Token
        guard let strEncodedToken = keychain[SerializationKeys.fcmToken] else { return nil }

        // 2. Decrypt the Auth Token
        guard let strFcmToken = strEncodedToken.base64Decoded?.base64Decoded else { return nil }

        return strFcmToken

    }
    

    /// This function will used to store the User's Email Address and Password in the Keychain access.
    ///
    ///     UserManager.storeUserDict(<OBJECT OF THE USER>)
    ///
    /// - Parameter user: Object of the User which you wanted to store in keychain
    /// - Returns: true if data is stored successfully in the keychain otherwise false.
    private func storeUser(_ user: User) -> Bool {

        do {
            let dataExample: Data = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: true)
            try keychain.set(dataExample, key: SerializationKeys.userData)
            /// comment becuse if user profile not comped then this will not true
            UDManager.isUserLogin = true
            return true
        } catch let error {
            Logger.log(error)
            return false
        }

    }
    

    /// This function will get the dictionary which is stored in the keychain for the last logged in user.
    ///
    /// - Returns: object of the Dictionary which is stored.
    private func getUser() -> User? {

        do {
            let data = try keychain.getData(SerializationKeys.userData)
            guard let aData: Data = data else { return nil }
            let aOBJUser = try NSKeyedUnarchiver.unarchivedObject(ofClass: User.self, from: aData)
            return aOBJUser
        } catch let error {
            Logger.log(error)
            return nil
        }
    }
}
