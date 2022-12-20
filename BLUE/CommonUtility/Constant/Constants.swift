//
//  Constants.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 28/09/22.
//

import Foundation
import UIKit
import Reachability
import KeychainAccess

let baseImageURL = "https://blue.testingjunction.tech/storage/"

struct StoryBoard{
    
    static let mainStoryBoard = "Main"
    static let bookingStoryBoard = "Booking"
    static let bottomBarStoryBoard = "BottomBar"
    static let homeStoryBoard = "Home"
    static let parkingStoryBoard = "Parking"
    static let accountStoryBoard = "Account"
    static let seafarerStoryBoard = "Seafarer"    
}
// APPSTORE version
let keychain = Keychain(service: "com.BLUE.keychain.development")


/// General object of Application Delegate
let APP_DELEGATE: AppDelegate                   =   UIApplication.shared.delegate as! AppDelegate



/// General object of UIApplication
let APPLICATION                                 =   UIApplication.shared


/// get the first root viewcontroller
var ROOT_FIRST_VC                               = UIApplication.shared.windows.first

/// General object of Main Bundle
let MAIN_BUNDLE                                 =   Bundle.main

/// General object of UserDefaults
let USER_DEFAULTS                               =   UserDefaults.standard

/// General object for the Reachability
let reachability                                = try! Reachability()

/// get the keywindow
let KEY_WINDOW                                  =  UIApplication.shared.windows.filter {$0.isKeyWindow}.first


/// General object ofthe Device Helper
let device = Device.current


struct LinkedInConstants {

    static let CLIENT_ID = "86c5dt9s8y0rw0"
    static let CLIENT_SECRET = "Hy90Qp70Tomm2Ppf"
    static let REDIRECT_URI = "https://www.gtfunded.com"
    static let SCOPE = "r_liteprofile%20r_emailaddress"
    static let AUTHURL = "https://www.linkedin.com/oauth/v2/authorization"
    static let TOKENURL = "https://www.linkedin.com/oauth/v2/accessToken"
    static let APIURL = "https://api.linkedin.com/v2/"
}


struct PlaceHolderImages {
    static let homelaceHolder = UIImage(named: "ic_placeholder")
}


enum facilitiesEnum: String  {
    case Wifi
    case Food
    case Restaurants
    case Television
    func getImag() -> UIImage {
        switch self {
        case .Wifi:
            return UIImage(named: "ic_wifi")!
        case .Food:
            return UIImage(named: "ic_food")!
        case .Restaurants:
            return UIImage(named: "ic_restaurent")!
        case .Television:
            return UIImage(named: "ic_tv")!

        }
    }
}
