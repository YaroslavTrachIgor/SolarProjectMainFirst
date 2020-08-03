//
//  AnalyticsManeger.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 14.05.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import FirebaseAnalytics

class AnalyticsManeger {
    static func addAnalyticsObject(name: String) {
        Analytics.logEvent(name, parameters: nil)
    }
    
    
    static func addAnaliticsObjectWithParameters(name: String, parameters: [String : Any]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
    
    static func addUserPropertie(name: String, forName: String) {
        Analytics.setUserProperty(name, forName: forName)
    }
}



//MARK: For UIButtons and UIBarButtonItems
extension AnalyticsManeger {
    
    //MARK: - Notifications Analytics
    static func addNotificationAnalytics(article name: String) {
        AnalyticsManeger.addAnalyticsObject(name: "notification_button_\(name)_pressed")
    }
    
    
    //MARK: - Support Analytics
    static func addSupportActionEmailAnalytics(for vc: String) {
        AnalyticsManeger.addUserPropertie(name: "email_support_for_\(vc)", forName: UserProperties.supportName)
    }
    
    
    static func addSupportActionMessageAnalytics(for vc: String) {
        AnalyticsManeger.addUserPropertie(name: "message_support_for_\(vc)", forName: UserProperties.supportName)
    }
    
    
    //MARK: - Share Analytics
    static func addShareActionAnalytics(for vc: String) {
        AnalyticsManeger.addUserPropertie(name: "share_action_for_\(vc)", forName: UserProperties.shareName)
    }
    
    
    //MARK: - Info about app VC Analytics
    static func addInfoVCctionAnalytics(for vc: String) {
        AnalyticsManeger.addUserPropertie(name: "info_about_app_open_for_\(vc)", forName: UserProperties.infoAboutAppName)
    }
    
    
    //MARK: - Safari Sytes Open Analytics
    static func addSafariFAQOpenAnalytics(for vc: String) {
        AnalyticsManeger.addUserPropertie(name: "open_faq_for_\(vc)", forName: UserProperties.safariSytesName)
    }
    
    
    static func addSafariMainSyteOpenAnalytics(for vc: String) {
        AnalyticsManeger.addUserPropertie(name: "open_syte_for_\(vc)", forName: UserProperties.safariSytesName)
    }
    
    
    //MARK: Login Options Analytics
    static func addLoginOptionsAnalytics(for option: String) {
        AnalyticsManeger.addUserPropertie(name: "logun_option_for_\(option)", forName: UserProperties.loginOptionsName)
    }
}



//MARK: - For UISwitch
extension AnalyticsManeger {
    static func addArtcileChangeFunctionsHiddenAnalytics(article name: String) {
        AnalyticsManeger.addAnalyticsObject(name: "article_switch_\(name)_switched")
    }
}



//MARK: - For UIStepper
extension AnalyticsManeger {
    static func addArtcileChangeFontAnalytics(article name: String) {
        AnalyticsManeger.addAnalyticsObject(name: "articlestepper_\(name)_font_change")
    }
    
    
    static func addTestChangeFontAnalytics() {
        AnalyticsManeger.addAnalyticsObject(name: "test_stepper_font_change")
    }
}



//MARK: - UserProperties
struct UserProperties {
    static let supportName = "Support"
    static let shareName = "Share"
    static let infoAboutAppName = "Info_About_App"
    static let safariSytesName = "Safari_Sytes"
    static let loginOptionsName = "Login_Options"
}
