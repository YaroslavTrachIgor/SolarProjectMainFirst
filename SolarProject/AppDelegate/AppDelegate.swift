//
//  AppDelegate.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit
import Parse
import GoogleMobileAds
import UserNotifications
import GoogleSignIn
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: Private
    private var googleService = BasicGoogleService()
    
    
    //MARK: Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNavigationBarBasics()
        setupBarButtonItemBasics()
        setupParseClientConfiguration()
        registerForPushNotifications()
        setupTabBarItemBasics()
        
        ///Configure Google Services
        googleService.configureGoogleMobileAds()
        googleService.setupGoogleSignInClientID()
        googleService.setupFirebase()
        
        return true
    }

    
    
    //MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}



//MARK: Main Methods
private extension AppDelegate {
    private func setupBarButtonItemBasics() {
        ///Setup barButton Appearence
        let barButtonAppearence = UIBarButtonItem.appearance()
        
        ///Set tintColor
        barButtonAppearence.tintColor = BasicProperties.color
    }
    
    private func setupTabBarItemBasics() {
        
        ///Setup barButton Appearence
        let tabBarAppearence = UITabBar.appearance()
        let tabBarItemAppearence = UITabBarItem.appearance()
        
        tabBarItemAppearence.badgeColor = BasicProperties.color
        
        ///Set tintColor
        tabBarAppearence.unselectedItemTintColor = #colorLiteral(red: 0.5382281652, green: 0.585738293, blue: 0.6582731492, alpha: 1)
        tabBarAppearence.selectedImageTintColor = BasicProperties.color
        
        ///Hide separator
        tabBarAppearence.shadowImage = UIImage()
    }
    
    private func setupNavigationBarBasics() {
        
        ///Setup navBar Appearence
        let navBarAppearence = UINavigationBar.appearance()
        
        ///Set tintColor
        navBarAppearence.tintColor = .orange
        
        ///Setup shadow
        navBarAppearence.layer.masksToBounds = false
        navBarAppearence.layer.shadowColor = UIColor.lightGray.cgColor
        navBarAppearence.layer.shadowOpacity = 0.8
        navBarAppearence.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navBarAppearence.layer.shadowRadius = 2
    }
    
    private func setupParseClientConfiguration() {
        let parseConfig = ParseClientConfiguration { config in
            config.applicationId = "OVazAp8AHtdi2ldjhjhfCq3KtTdILMCf1YETzxRL"
            config.clientKey = "Fe9OY5gzrOPFUNrvXxK3OjMOimjvNT1bFWeYskNP"
            config.server = "https://parseapi.back4app.com/"
        }
        Parse.initialize(with: parseConfig)
    }
    
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
        (granted, error) in
            print("Permission granted: \(granted)")
        }
    }
}



//MARK: - BasicGoogleServices extension
final class BasicGoogleService {
    internal func configureGoogleMobileAds() {
        
        ///Start GADMobileAds sharedInstance
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    internal func setupGoogleSignInClientID() {
        
        ///Setup GIDSignIn clientID
        GIDSignIn.sharedInstance().clientID = "1058440591328-jh1ff789so5qqu73cf6pfj6110ujmd9a.apps.googleusercontent.com"
    }
    
    internal func setupFirebase() {
        
        ///Configure Firebase
        FirebaseApp.configure()
    }
}
