//
//  Utility.swift
//  BLUE
//
//  Created by Bhikhu on 05/10/22.
//

import Foundation
import UIKit

/// Utility class for application
public class Utility {

    // MARK: - singleton sharedInstance
    static var sharedInstance = Utility()

    
    /// Dispatch Queue delay with compltion handler
    /// - Parameters:
    ///   - delay: delay time
    ///   - closure: compltion call back
    static func delay(_ delay: Double, closure:@escaping () -> Void) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
    /// Application icon badge current number.
    public static var applicationIconBadgeNumber: Int {
        get {
            return APPLICATION.applicationIconBadgeNumber
        }
        set {
            
            // Always add unread chat count in Badge number...
            APPLICATION.applicationIconBadgeNumber = newValue  // + (UDManager.unreadChatCount ?? 0)
            
            // Post notification to update unread notifications count...
            NotificationCenter.default.post(name: .notificationBadgeCountUpdated, object: nil, userInfo: nil)
        }
    }
    
    /// This method will return a Top Most View Controller of the application's window which you wan use.
    ///
    /// - Returns: Object of the UIViewController
    public func topMostController() -> UIViewController {
        let arrWind = APPLICATION.windows
        if arrWind.count > 0 {
            if let keyWndw = APPLICATION.windows.filter({$0.isKeyWindow}).first {
                var topController: UIViewController = keyWndw.rootViewController!
                while topController.presentedViewController != nil {
                    topController = topController.presentedViewController!
                }
                return topController
            }
        }
        return UIViewController()
    }
    
    static var headerTimeStamp: String {
        return "\(Int(Date().timeIntervalSince1970))"
    }
    
    /// App's current version (if applicable).
    public static var appVersion: String? {
        return MAIN_BUNDLE.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// This method will set root menu video controller
    ///
    /// - Parameters:
    ///   - isFromNotification: set coming from notification

    static func setRootScreen(isAnimation: Bool = false) {
        if UDManager.isUserLogin {
            let controller =  BottomBarController.instantiate()
            setRootWithAnimation(vc: controller, isAnimation: isAnimation)
        } else {
            let controller =  LoginVC.instantiate()
            setRootWithAnimation(vc: controller, isAnimation: isAnimation)
        }
    }
    
    static  func setRootWithAnimation (vc: UIViewController, isAnimation: Bool) {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        if isAnimation {
            UIView.transition(with: ROOT_FIRST_VC!,
                                  duration: 0.5, options: .transitionFlipFromLeft,
                                  animations: {
                                    ROOT_FIRST_VC?.rootViewController = navigationController
                                    ROOT_FIRST_VC?.makeKeyAndVisible()

                                  }, completion: { _ in

                                  })
        } else {
            ROOT_FIRST_VC?.makeKeyAndVisible()
            ROOT_FIRST_VC?.rootViewController = navigationController
        }
    }
    
    static var timestamp: String {
        return "\(Int(Date().timeIntervalSince1970 * 1000))"
    }
}

