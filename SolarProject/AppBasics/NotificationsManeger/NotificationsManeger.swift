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
    public struct PushNotificationsBasicWords {
        static let headers: [String] = ["It's time for you to read about ",
                                        "Don't forget to read about "]
        static let soundNames: [String] = ["Default",
                                           "Bulletin",
                                           "Crystals",
                                           "Presto",
                                           "Radar"]
        static let userAction = "User Action"
    }
    
    //MARK: Setup Notification
    static func setupBasicNotification(body: String, date: Date) {
        
        ///Remove Notififications
        removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
        
        ///Setup Content
        let content = UNMutableNotificationContent()
        let header = PushNotificationsBasicWords.headers.randomElement()
        let categoryIdentifier = PushNotificationsBasicWords.userAction
        
        ///Setup notification body
        if NotificationsSettings.shared.notificationsBody == "Message:" {
            content.body = header! + body
        } else {
            content.body = NotificationsSettings.shared.notificationsBody + body
        }
        
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = categoryIdentifier
        
        ///Setup Center)
        let requestIdentifier = "NotificationIdentifier"
        let dateComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second,]
        let triggerDate = Calendar.current.dateComponents(dateComponents, from: date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        ///Setup Actions
        let deleteIdentifier = "DeleteAction"
        let deleteTitle = "Delete"
        let deleteActionOption: UNNotificationActionOptions = [.destructive]
        let deleteAction = UNNotificationAction(identifier: deleteIdentifier, title: deleteTitle, options: deleteActionOption)
        let category = UNNotificationCategory(identifier: categoryIdentifier, actions: [deleteAction], intentIdentifiers: [], options: [])
        
        ///Setup Categories
        center.setNotificationCategories([category])
        
        ///Setup Request
        center.add(request, withCompletionHandler: nil)
    }
}



//MARK: - Remove Notifications Function (Public Method)
public func removeNotifications(withIdentifiers identifiers: [String])   {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: identifiers)
}
