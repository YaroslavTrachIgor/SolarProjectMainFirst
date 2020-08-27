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

//MARK: - Keys
extension AppDelegate {
    public struct Keys {
        public enum ParseKeys: String {
            case applicationId = "OVazAp8AHtdi2ldjhjhfCq3KtTdILMCf1YETzxRL"
            case clientKey = "Fe9OY5gzrOPFUNrvXxK3OjMOimjvNT1bFWeYskNP"
            case server = "https://parseapi.back4app.com/"
        }
        
        public enum GIDSignInKeys: String {
            case clientID = "1058440591328-jh1ff789so5qqu73cf6pfj6110ujmd9a.apps.googleusercontent.com"
        }
    }
}


@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: Private
    private var googleService: BasicGoogleServiceProtocol?
    
    
    //MARK: Lifecycle
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNavigationBarBasics()
        setupBarButtonItemBasics()
        setupParseClientConfiguration()
        registerForPushNotifications()
        setupTabBarItemBasics()
        setupGoogleServices()
        
        return true
    }

    
    
    //MARK: UISceneSession Lifecycle
    internal func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    internal func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}



//MARK: - Main Methods
private extension AppDelegate {
    private func setupGoogleServices() {
        confureGoogleService()
        googleService?.configureGoogleMobileAds()
        googleService?.setupGoogleSignInClientID()
        googleService?.setupFirebase()
    }
    
    private func confureGoogleService() {
        googleService = BasicGoogleService()
    }
    
    private func setupBarButtonItemBasics() {
        let barButtonAppearence = UIBarButtonItem.appearance()
        barButtonAppearence.tintColor = BasicProperties.color
    }
    
    private func setupTabBarItemBasics() {
        let tabBarAppearence = UITabBar.appearance()
        let tabBarItemAppearence = UITabBarItem.appearance()
        tabBarItemAppearence.badgeColor = BasicProperties.color
        tabBarAppearence.unselectedItemTintColor = #colorLiteral(red: 0.5382281652, green: 0.585738293, blue: 0.6582731492, alpha: 1)
        tabBarAppearence.selectedImageTintColor = BasicProperties.color
        tabBarAppearence.shadowImage = UIImage()
    }
    
    private func setupNavigationBarBasics() {
        let navBarAppearence = UINavigationBar.appearance()
        navBarAppearence.tintColor = .orange
        navBarAppearence.layer.masksToBounds = false
        navBarAppearence.layer.shadowColor = UIColor.lightGray.cgColor
        navBarAppearence.layer.shadowOpacity = 0.8
        navBarAppearence.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navBarAppearence.layer.shadowRadius = 2
    }
    
    private func setupParseClientConfiguration() {
        let parseConfig = ParseClientConfiguration { config in
            config.applicationId = Keys.ParseKeys.applicationId.rawValue
            config.clientKey = Keys.ParseKeys.clientKey.rawValue
            config.server = Keys.ParseKeys.server.rawValue
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



//MARK: - BasicGoogleServices BasicGoogleServiceProtocol
fileprivate protocol BasicGoogleServiceProtocol: class {
    func configureGoogleMobileAds()
    func setupGoogleSignInClientID()
    func setupFirebase()
}



//MARK: - BasicGoogleService main class
final class BasicGoogleService: BasicGoogleServiceProtocol {
    internal func configureGoogleMobileAds() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    internal func setupGoogleSignInClientID() {
        GIDSignIn.sharedInstance().clientID = AppDelegate.Keys.GIDSignInKeys.clientID.rawValue
    }
    
    internal func setupFirebase() {
        FirebaseApp.configure()
    }
}
