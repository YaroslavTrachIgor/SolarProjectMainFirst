//
//  NotificationsFunctions.swift
//  GoodBiology
//
//  Created by Yaroslav on 12/18/18.
//  Copyright © 2018 Yaroslav. All rights reserved.
//

import Foundation
import UserNotifications

//MARK: - PushNotifications Maneger
struct PushNotifications {
    
    //MARK: Setup Basic Words
    struct PushNotificationsBasicWords {
        static let basicNotificationHeader: String = "Will you be able to read something about "
        static let userAction = "User Action"
    }
    
    //MARK: Setup Notification
    static func setupBasicNotification(body: String, inSecond seconds: TimeInterval, completion: (Bool) -> ()) {
        
        ///Remove Notififications
        removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
        
        ///Setup Date
        let date = Date(timeIntervalSinceNow: seconds)
        
        ///Setup Content
        let content = UNMutableNotificationContent()
        content.title = "Let's Go !"
        content.body  = PushNotificationsBasicWords.basicNotificationHeader + body + "?"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = PushNotificationsBasicWords.userAction
        
        ///Setup Center
        let calendar        = Calendar(identifier: .gregorian)
        let components      = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
        let trigger         = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request         = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
        let center          = UNUserNotificationCenter.current()
        let deleteAction    = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category        = UNNotificationCategory(identifier: PushNotificationsBasicWords.userAction, actions: [deleteAction], intentIdentifiers: [], options: [])
        
        ///Setup Categories
        center.setNotificationCategories([category])
        
        ///Setup Request
        center.add(request, withCompletionHandler: nil)
    }
}



//MARK: - BasicPushNotificationAttributes
struct BasicPushNotificationAttributes {
    
    //Basic time interval
    static let timeInterval = 720

    //Basic frases
    static let congratsText = "We send it !"
    static let failText     = "Failed"

    static let endOfTextBiolgyNotification: String = " of Biology."
}



//MARK: - Remove Notifications Function (Public Method)
public func removeNotifications(withIdentifiers identifiers: [String])   {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: identifiers)
}
