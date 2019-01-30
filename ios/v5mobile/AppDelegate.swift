//
//  AppDelegate.swift
//  v5mobile
//
//  Created by max on 2018-09-03.
//  Copyright © 2018 max. All rights reserved.
//

import UIKit
import AdSupport
import UserNotifications

import ACPCore
import ACPAnalytics
import ACPTarget
import ACPUserProfile


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    /**
     * Save state if authenticated
     */
    var authState: Bool?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override for customization after application launch.
        let appIdConfig = self.readConfigFromStorage()
        
        ACPCore.setLogLevel(ACPMobileLogLevel.debug)
        //ACPCore.setLogLevel(ACPMobileLogLevel.verbose);
        ACPCore.configure(withAppId: appIdConfig);
        ACPIdentity.registerExtension();
        ACPUserProfile.registerExtension();
        //ACPAudience.registerExtension()
        //ACPCampaign.registerExtension()
        ACPTarget.registerExtension();
        ACPAnalytics.registerExtension();
        ACPLifecycle.registerExtension();
        ACPSignal.registerExtension();
        
        /**
         * Set AdID in the context
         */
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        ACPCore.setAdvertisingIdentifier(idfa)
        
        ACPCore.start {
            ACPCore.lifecycleStart(nil)
        }
        /**
         * Register for push notifications
         */
        if #available( iOS 10.0, *) {
            // For  10 display notification (sent via APNS)
            //UNUserNotificationCenter.current().delegate = self
            let center = UNUserNotificationCenter.current()
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            center.requestAuthorization(options: authOptions) {
                (granted, error) in
                if !granted {
                    print("User Notification permission denied: \(String(describing: error?.localizedDescription))")
                }
            }
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()

        return true
    }
    
    func readConfigFromStorage() -> String {

        print("reading config from storage - overidding default config.")
        let defaults = UserDefaults.standard
        if let launchConfig = defaults.string(forKey: "launchConfig") {
            print(launchConfig)
            return launchConfig
        } else {
            /* max launch prod */
            return "launch-EN58fdfb72764a4f81b0aaaaa3af9f8e95"
        }
    }
    /**
     * Helper to generate a device token.
     */
    func tokenString(_ deviceToken:Data) -> String {
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes {
            token += String(format: "%02x",byte)
        }
        return token
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        print("Successful registration. Token is:")
        print(tokenString(deviceToken))
        
        /**
         * Sending push identifier deviceToken to APNS and ACS mobile app registration.
         * @note There seems to be a missing part here for ACS. @max: debug!
         */
        ACPCore.setPushIdentifier(deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification")
        //let deeplinkString = userInfo["adb_deeplink"] as? String
        //let pushPayloadId = userInfo["adb_m_id"] as? String
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        ACPCore.lifecyclePause()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        ACPCore.lifecyclePause()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        ACPCore.lifecycleStart(["state":"appResume"])
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

