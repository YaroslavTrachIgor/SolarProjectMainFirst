//
//  NotificationsSettings.swift
//  SolarProject
//
//  Created by Yaroslav on 06.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import AudioToolbox

//MARK: - NotificationsSettings main class
final class NotificationsSettings {
    
    //MARK: NotificationsSettingsKeys
    public enum NotificationsSettingsKeys: String {
        case isOn = "NotificationsOnKey"
        case notificationsBody = "NotificationMessageKey"
        case notificationsSound = "NotificationSoundKey"
    }
    
    
    //MARK: Init
    private init() {}
    
    
    //MARK: Shared
    static let shared = NotificationsSettings()
    
    
    //MARK: Main Settings Varibles
    var notificationsOn: Bool = defaults.value(forKey: NotificationsSettingsKeys.isOn.rawValue) as? Bool ?? true
    var notificationsBody: String = defaults.value(forKey: NotificationsSettingsKeys.notificationsBody.rawValue) as? String ?? "Message:"
    var notificationsSound: String? = defaults.value(forKey: NotificationsSettingsKeys.notificationsSound.rawValue) as? String ?? ""
}



//MARK: - NotificationsSettings public extension(setup audio)
extension NotificationsSettings {
    
    //MARK: Public
    public func setupAudio() {
        switch notificationsSound {
        case "Default":
            playSound(with: 1002)
        case "Bulletin":
            playSound(with: 1001)
        case "Crystals":
            playSound(with: 1003)
        case "Presto":
            playSound(with: 1004)
        case "Radar":
            playSound(with: 1005)
        default:
            playSound(with: 1002)
        }
    }
    
    //MARK: Private
    private func playSound(with id: Int) {
        AudioServicesPlaySystemSound(SystemSoundID(id))
    }
}
