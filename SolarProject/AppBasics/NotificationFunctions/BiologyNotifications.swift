//
//  BiologyNotifications.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 1/22/19.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UserNotifications

public let endOfTextBiolgyNotification: String = " of Biology."

func basicsScheduleNotification(inSecond seconds: TimeInterval, completion: (Bool) -> ())
{
    removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
    
    let date            = Date(timeIntervalSinceNow: seconds)
    print(Date())
    print(date)
    
    let content         = UNMutableNotificationContent()
    
        content.title       = "Let's Go !"
        content.body        = basicNotificationHeader + "Basics" + endOfTextBiolgyNotification
        content.sound       = UNNotificationSound.default
        content.categoryIdentifier = userAction
    
    let calendar        = Calendar(identifier: .gregorian)
    let components      = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
    let trigger         = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request         = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
    let center          = UNUserNotificationCenter.current()
    let deleteAction    = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
    let category        = UNNotificationCategory(identifier: userAction, actions: [deleteAction], intentIdentifiers: [], options: [])
    
    center.setNotificationCategories([category])
    center.add(request, withCompletionHandler: nil)
}

func historyScheduleNotification(inSecond seconds: TimeInterval, completion: (Bool) -> ())
{
    removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
    
    let date            = Date(timeIntervalSinceNow: seconds)
    print(Date())
    print(date)
    
    let content         = UNMutableNotificationContent()
    
        content.title       = "Let's Go !"
        content.body        = basicNotificationHeader + "History" + endOfTextBiolgyNotification
        content.sound       = UNNotificationSound.default
        content.categoryIdentifier = userAction
    
    let calendar        = Calendar(identifier: .gregorian)
    let components      = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
    let trigger         = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request         = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
    let center          = UNUserNotificationCenter.current()
    let deleteAction    = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
    let category        = UNNotificationCategory(identifier: userAction, actions: [deleteAction], intentIdentifiers: [], options: [])
    
    center.setNotificationCategories([category])
    center.add(request, withCompletionHandler: nil)
}

func historyPTwoScheduleNotification(inSecond seconds: TimeInterval, completion: (Bool) -> ())
{
    removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
    
    let date            = Date(timeIntervalSinceNow: seconds)
    print(Date())
    print(date)
    
    let content         = UNMutableNotificationContent()
    
        content.title       = "Let's Go !"
        content.body        = basicNotificationHeader + "History p.2" + endOfTextBiolgyNotification
        content.sound       = UNNotificationSound.default
        content.categoryIdentifier = userAction
    
    let calendar        = Calendar(identifier: .gregorian)
    let components      = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
    let trigger         = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request         = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
    let center          = UNUserNotificationCenter.current()
    let deleteAction    = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
    let category        = UNNotificationCategory(identifier: userAction, actions: [deleteAction], intentIdentifiers: [], options: [])
    
    center.setNotificationCategories([category])
    center.add(request, withCompletionHandler: nil)
}

func cellTheotyScheduleNotification(inSecond seconds: TimeInterval, completion: (Bool) -> ())
{
    removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
    
    let date            = Date(timeIntervalSinceNow: seconds)
    print(Date())
    print(date)
    
    let content         = UNMutableNotificationContent()
    
        content.title       = "Let's Go !"
        content.body        = basicNotificationHeader + "Cell Theory" + endOfTextBiolgyNotification
        content.sound       = UNNotificationSound.default
        content.categoryIdentifier = userAction
    
    let calendar        = Calendar(identifier: .gregorian)
    let components      = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
    let trigger         = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request         = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
    let center          = UNUserNotificationCenter.current()
    let deleteAction    = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
    let category        = UNNotificationCategory(identifier: userAction, actions: [deleteAction], intentIdentifiers: [], options: [])
    
    center.setNotificationCategories([category])
    center.add(request, withCompletionHandler: nil)
}

func evolutionScheduleNotification(inSecond seconds: TimeInterval, completion: (Bool) -> ())
{
    removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
    
    let date            = Date(timeIntervalSinceNow: seconds)
    print(Date())
    print(date)
    
    let content         = UNMutableNotificationContent()
    
        content.title       = "Let's Go !"
        content.body        = basicNotificationHeader + "Evolution" + endOfTextBiolgyNotification
        content.sound       = UNNotificationSound.default
        content.categoryIdentifier = userAction
    
    let calendar        = Calendar(identifier: .gregorian)
    let components      = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
    let trigger         = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request         = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
    let center          = UNUserNotificationCenter.current()
    let deleteAction    = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
    let category        = UNNotificationCategory(identifier: userAction, actions: [deleteAction], intentIdentifiers: [], options: [])
    
    center.setNotificationCategories([category])
    center.add(request, withCompletionHandler: nil)
}

func geneticsScheduleNotification(inSecond seconds: TimeInterval, completion: (Bool) -> ())
{
    removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
    
    let date            = Date(timeIntervalSinceNow: seconds)
    print(Date())
    print(date)
    
    let content         = UNMutableNotificationContent()
    
        content.title       = "Let's Go !"
        content.body        = basicNotificationHeader + "Genetics" + endOfTextBiolgyNotification
        content.sound       = UNNotificationSound.default
        content.categoryIdentifier = userAction
    
    let calendar        = Calendar(identifier: .gregorian)
    let components      = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
    let trigger         = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request         = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
    let center          = UNUserNotificationCenter.current()
    let deleteAction    = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
    let category        = UNNotificationCategory(identifier: userAction, actions: [deleteAction], intentIdentifiers: [], options: [])
    
    center.setNotificationCategories([category])
    center.add(request, withCompletionHandler: nil)
}

func structularScheduleNotification(inSecond seconds: TimeInterval, completion: (Bool) -> ())
{
    removeNotifications(withIdentifiers: ["MyUniqueIdentifier"])
    
    let date            = Date(timeIntervalSinceNow: seconds)
    print(Date())
    print(date)
    
    let content         = UNMutableNotificationContent()
    
        content.title       = "Let's Go !"
        content.body        = basicNotificationHeader + "Structular" + endOfTextBiolgyNotification
        content.sound       = UNNotificationSound.default
        content.categoryIdentifier = userAction
    
    let calendar        = Calendar(identifier: .gregorian)
    let components      = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
    let trigger         = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request         = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
    let center          = UNUserNotificationCenter.current()
    let deleteAction    = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
    let category        = UNNotificationCategory(identifier: userAction, actions: [deleteAction], intentIdentifiers: [], options: [])
    
    center.setNotificationCategories([category])
    center.add(request, withCompletionHandler: nil)
}
