//
//  AppDelegate.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 4/15/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    private let baseURLString: String = "https://obscure-cliffs-52108.herokuapp.com/"
    
    private let publishableKey: String = Stripe_key
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(googleMap_Key)
        GMSPlacesClient.provideAPIKey(googlePlace_key)
        FirebaseApp.configure()
        STPPaymentConfiguration.shared().publishableKey = Stripe_key
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "hasRunBefore") == false {
            print("The app is launching for the first time. Setting UserDefaults...")
            
            do {
                try Auth.auth().signOut()
            } catch {
                
            }
            
            // Update the flag indicator
            userDefaults.set(true, forKey: "hasRunBefore")
            userDefaults.synchronize() // This forces the app to update userDefaults
            
            // Run code here for the first launch
            
        } else {
            print("The app has been launched before. Loading UserDefaults...")
            // Run code here for every other launch but the first
        }
        
        
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

    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override init() {
        super.init()
        
        // Stripe payment configuration
        STPPaymentConfiguration.shared().companyName = "Campus Connect LLC"
        
        if !publishableKey.isEmpty {
            STPPaymentConfiguration.shared().publishableKey = publishableKey
        }
        
        // Main API client configuration
        MainAPIClient.shared.baseURLString = baseURLString
        
        
    }

}

