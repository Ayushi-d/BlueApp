//
//  AppDelegate.swift
//  BLUE
//
//  Created by Agyapal Dhiman on 22/09/22.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn
import FBSDKCoreKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?

    //Google Map key
    //AIzaSyCYISBUr25Gne9q7F9oBQPSqa0cKZVF3z0
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        setupKeyboard()
        setBasepath()
        setSignInWithGoogle()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        sleep(2)
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound]) { sucess, _ in
            guard sucess else{
                 return
            }
            print("Register for notification Successfully")
        }
        
        application.registerForRemoteNotifications()
        return true
    }
    
    func setupKeyboard()  {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func setBasepath() {
        UDManager.baseURLPath = API.URL.imageUrl
    }
    
    func setSignInWithGoogle(){
        GIDSignIn.sharedInstance().clientID = "930463847306-ogbho5sailuq08dm9umiuhp422hp3nf4.apps.googleusercontent.com"
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, error in
            guard let token = token else{
                print(error?.localizedDescription)
                return
            }
            UserDefaults.standard.set(token, forKey: "fcmToken")
            UserDefaults.standard.synchronize()
            print("fcmToken---", token)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //return ((GIDSignIn.sharedInstance()?.handle(url)))!
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }

}

