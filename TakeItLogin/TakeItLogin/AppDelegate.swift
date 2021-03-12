//
//  AppDelegate.swift
//  TakeItLogin
//
//  Created by Mutyumu on 2021/3/3.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn
import AdSupport
import TPDirect


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        TPDSetup.setWithAppId(19246, withAppKey: "app_Yk3iIg5Okb8HhWFqWnuaJhHgkaWnRtIEVNOycEAIaIiNNmbo4FOSGyv5RRTj", with: TPDServerType.sandBox)
    
        let IDFA = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        // Please setup Advertising  Identifier, to improve the accuracy of fraud detect.
        TPDSetup.shareInstance().setupIDFA(IDFA)
        
        TPDSetup.shareInstance().serverSync()
        
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        FirebaseApp.configure()
        return true
    }

    func application( _ app:UIApplication, open url:URL, options: [UIApplication.OpenURLOptionsKey :Any] = [:] ) -> Bool {
        let facebook = ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        let google = GIDSignIn.sharedInstance()?.handle(options[UIApplication.OpenURLOptionsKey.sourceApplication] as? URL)
        
        return facebook || (google != nil)
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


}

