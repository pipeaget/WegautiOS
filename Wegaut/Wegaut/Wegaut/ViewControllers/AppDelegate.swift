//
//  AppDelegate.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/11/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Setting the back-end enviorment for all the project.
        var isOnDev = true
        #if DEBUG
        isOnDev = true
        #else
        isOnDev = false
        #endif
        UserDefaults.standard.set(isOnDev,
                                  forKey: WegautConstants.IS_DEV_APP)
        
        //Navigation bar appearance
        let navAppearance = UINavigationBar.appearance()
        navAppearance.barTintColor = UIColor.white
        navAppearance.tintColor = UIColor.deepPurple
        navAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)]
        
        //Tab bar appearance
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = UIColor.white
        tabBarAppearance.tintColor = UIColor.mediumPurple
        tabBarAppearance.unselectedItemTintColor = UIColor.lightGray
        
        //Search bar appearance
        let tfAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        tfAppearance.defaultTextAttributes = convertToNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.mediumPurple])
        tfAppearance.tintColor = UIColor.white
        
        //Initialize IQkeyaboard
        IQKeyboardManager.shared().isEnabled = true
        
        let isLogged: Bool = UserDefaults.standard.bool(forKey: WegautConstants.IS_USER_LOGGED)
        let storyboard: UIStoryboard = UIStoryboard(name: isLogged ? "Main" : "Login",
                                                    bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: isLogged ? "RootNavigation" : "RootLogin")
        window?.rootViewController = vc
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
