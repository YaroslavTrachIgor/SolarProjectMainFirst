//
//  AlertsManeger.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 19.05.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import SwiftEntryKit

class AlertsManeger {
    
    // Notification View animation
    private func setupDoneTestPopViewAttributes() -> EKAttributes {
        return EKAttributesManeger.setupNotificationViewEKAttributes()
    }
    
    public func showNotificationView() {
        SwiftEntryKit.display(entry: NotificationView.instanceFromNib(), using: setupDoneTestPopViewAttributes())
    }
}
