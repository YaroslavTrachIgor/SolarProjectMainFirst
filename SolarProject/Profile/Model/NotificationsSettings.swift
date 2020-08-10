//
//  NotificationsSettings.swift
//  SolarProject
//
//  Created by Yaroslav on 06.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - NotificationsSettings main class
final class NotificationsSettings {
    
    //MARK: Init
    private init() {}
    
    //MARK: Shared
    static let shared = NotificationsSettings()
    
    
    //MARK: Main Settings Varibles
    var notificationsOn: Bool = defaults.value(forKey: "NotificationsOnKey") as? Bool ?? true
}
