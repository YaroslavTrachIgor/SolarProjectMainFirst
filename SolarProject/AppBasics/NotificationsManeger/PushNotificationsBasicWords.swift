//
//  PushNotificationsBasicWords.swift
//  SolarProject
//
//  Created by Yaroslav on 12.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - PushNotifications extension
public extension PushNotifications {
    
    //MARK: Setup Basic Words
    struct PushNotificationsBasicWords {
        static let headers: [String] = ["It's time for you to read about ",
                                        "Don't forget to read about "]
        static let soundNames: [String] = ["Default",
                                           "Bulletin",
                                           "Crystals",
                                           "Presto",
                                           "Radar"]
        static let userAction = "User Action"
    }
}
