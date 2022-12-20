import Foundation
import UIKit
class UDManager {
    //    class var example: String? {
    //        get {
    //            return UserDefaults.standard[#function] ?? nil
    //        }
    //        set {
    //            if newValue == nil {
    //                UserDefaults.standard.removeObject(forKey: #function)
    //            } else {
    //                UserDefaults.standard[#function] = newValue
    //            }
    //        }
    //    }

    //    class var exampleArray: [Any]? {
    //        get {
    //
    //            let decoded = UserDefaults.standard[#function] ?? Data()
    //            //'unarchiveObject(with:)' was deprecated in iOS 12.0: Use +unarchivedObjectOfClass:fromData:error: instead
    //            //                        let dt = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Any.self], from: decoded) as? [Any]
    //            //            let dt = (try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Any.self], from: decoded)) as? [Any]
    //            let dt =  try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [Any]
    //            return dt
    //        }
    //        set {
    //
    //            if newValue == nil {
    //                UserDefaults.standard.removeObject(forKey: #function)
    //            } else {
    //                let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
    //                //                UserDefaults.standard.setValue(encodedData, forKey: #function)
    //                UserDefaults.standard[#function] = encodedData
    //            }
    //
    //        }
    //    }

    /// Store the Bool value which identifies that Walkthrough has been displayed or not.
    class var isWalkthroughDisplayed: Bool {
        get {
            return USER_DEFAULTS.bool(forKey: #function)
        }
        set {
            USER_DEFAULTS.set(newValue, forKey: #function)
            USER_DEFAULTS.synchronize()
        }
    }

    /// This will store the DeviceToken for the Push notification
    class var deviceToken: String? {
        get {
            return USER_DEFAULTS.string(forKey: #function)
        }
        set {
            if newValue == nil {
                USER_DEFAULTS.removeObject(forKey: #function)
            } else {
                let strEncoded = newValue
                USER_DEFAULTS.setValue(strEncoded, forKey: #function)
                USER_DEFAULTS.synchronize()
            }
        }
    }
    
    class var deviceTokenData: Data? {
        get {
            return UserDefaults.standard[#function]
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                UserDefaults.standard[#function] = newValue
            }
        }
    }
   
    /// This will store the Firebase DeviceToken for the Push notification
    class var fcmDeviceToken: String? {
        get {
            return USER_DEFAULTS.string(forKey: #function)
        }
        set {
            if newValue == nil {
                USER_DEFAULTS.removeObject(forKey: #function)
            } else {
                let strEncoded = newValue
                USER_DEFAULTS.setValue(strEncoded, forKey: #function)
                USER_DEFAULTS.synchronize()
            }
        }
    }
    
    
    /// This will store deice uniqe id
    class var deviceUniqueId: String? {
        get {
            return USER_DEFAULTS.string(forKey: #function)
        }
        set {
            if newValue == nil {
                USER_DEFAULTS.removeObject(forKey: #function)
            } else {
                let strEncoded = newValue
                USER_DEFAULTS.setValue(strEncoded, forKey: #function)
                USER_DEFAULTS.synchronize()
            }
        }
    }

    /// Check If user has Enabled the push notification from the settings or not.
    class var isPushNotificationEnabled: Bool {
        get {
            return USER_DEFAULTS.bool(forKey: #function)
        }
        set {
            USER_DEFAULTS.set(newValue, forKey: #function)
            USER_DEFAULTS.synchronize()
        }
    }

    /// This will store the value in UD that if user is logged in or not.
    class var isUserLogin: Bool {
        get {
            return USER_DEFAULTS.bool(forKey: #function)
        }
        set {
            USER_DEFAULTS.set(newValue, forKey: #function)
            USER_DEFAULTS.synchronize()
        }
    }

    /// Suggestion draft which was saved by the user while cancelling the screen.
    class var appOpenCounter: Int {
        get {
            return USER_DEFAULTS.integer(forKey: #function)
        }
        set {
            USER_DEFAULTS.set(newValue, forKey: #function)
        }
    }

    class var baseURLPath: String? {
        get {

            let decoded = UserDefaults.standard[#function] ?? Data()
            // 'unarchiveObject(with:)' was deprecated in iOS 12.0: Use +unarchivedObjectOfClass:fromData:error: instead
            // let dt = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded) as? [Plans]
            // let dt = (try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded)) as? [Plans]
            let dt = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? String
            return dt
        }
        set {

            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
                // UserDefaults.standard.setValue(encodedData, forKey: #function)
                UserDefaults.standard[#function] = encodedData
            }

        }
    }

    
    class var investorRoleArray: [String]? {
        get {

            let decoded = UserDefaults.standard[#function] ?? Data()
            // 'unarchiveObject(with:)' was deprecated in iOS 12.0: Use +unarchivedObjectOfClass:fromData:error: instead
            // let dt = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded) as? [Plans]
            // let dt = (try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded)) as? [Plans]
            let dt = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [String]
            return dt
        }
        set {

            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
                // UserDefaults.standard.setValue(encodedData, forKey: #function)
                UserDefaults.standard[#function] = encodedData
            }

        }
    }
    class var investorRoleEditArray: [String]? {
        get {

            let decoded = UserDefaults.standard[#function] ?? Data()
            // 'unarchiveObject(with:)' was deprecated in iOS 12.0: Use +unarchivedObjectOfClass:fromData:error: instead
            // let dt = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded) as? [Plans]
            // let dt = (try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded)) as? [Plans]
            let dt = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [String]
            return dt
        }
        set {

            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
                // UserDefaults.standard.setValue(encodedData, forKey: #function)
                UserDefaults.standard[#function] = encodedData
            }

        }
    }

    class var investmentstagesArray: [String]? {
        get {

            let decoded = UserDefaults.standard[#function] ?? Data()
            // 'unarchiveObject(with:)' was deprecated in iOS 12.0: Use +unarchivedObjectOfClass:fromData:error: instead
            // let dt = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded) as? [Plans]
            // let dt = (try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded)) as? [Plans]
            let dt = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [String]
            return dt
        }
        set {

            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
                // UserDefaults.standard.setValue(encodedData, forKey: #function)
                UserDefaults.standard[#function] = encodedData
            }

        }
    }
    class var investmentstagesEditArray: [String]? {
        get {

            let decoded = UserDefaults.standard[#function] ?? Data()
            // 'unarchiveObject(with:)' was deprecated in iOS 12.0: Use +unarchivedObjectOfClass:fromData:error: instead
            // let dt = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded) as? [Plans]
            // let dt = (try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Plans.self], from: decoded)) as? [Plans]
            let dt = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [String]
            return dt
        }
        set {

            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
                // UserDefaults.standard.setValue(encodedData, forKey: #function)
                UserDefaults.standard[#function] = encodedData
            }

        }
    }

    
    class var isSynchMeeting: Bool {
        get {
            return USER_DEFAULTS.bool(forKey: #function)
        }
        set {
            USER_DEFAULTS.set(newValue, forKey: #function)
            USER_DEFAULTS.synchronize()
        }
    }
    
    /// This will store the value in UD that if feed player is mute or not in or not.
    class var isFeedPlayerMute: Bool {
        get {
            return USER_DEFAULTS.bool(forKey: #function)
        }
        set {
            USER_DEFAULTS.set(newValue, forKey: #function)
            USER_DEFAULTS.synchronize()
        }
    }

    
    /// unreadChatCount: Used to save the unread Chat count
    class var unreadChatCount: Int? {
        get {
            return UserDefaults.standard[#function]
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                UserDefaults.standard[#function] = newValue
            }
        }
    }
    
    /// lastSyncedDate: Use this object to store the Last Synced Date
    class var lastSyncedDate: Date? {
        get {
            return UserDefaults.standard[#function]
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: #function)
            } else {
                UserDefaults.standard[#function] = newValue
            }
        }
    }
    /// This will store the value of Username in the userDefault.
    ///
    /// To SET the values
    ///
    ///     UDSettings.username = "Bhikhu123"
    ///
    ///
    /// To GET the values
    ///
    ///     print(UDSettings.username)
    ///
    class var username: String {
        get {
            return UserDefaults.standard[#function] ?? ""
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }

    class var loggedUserID: String {
           get {
               return UserDefaults.standard[#function] ?? ""
           }
           set {
               UserDefaults.standard[#function] = newValue
           }
       }

    class var loggedMobileNumber: String {
        get {
            return UserDefaults.standard[#function] ?? ""
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    class var defaultLanguage: String {
        get {
            return UserDefaults.standard[#function] ?? ""
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }


}
extension UserDefaults {

    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }

    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set {
            set(newValue?.rawValue, forKey: key)
        }
    }
}
