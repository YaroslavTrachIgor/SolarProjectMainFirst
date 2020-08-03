//
//  UIApplictionExtensions.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 29.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIApplication extension
extension UIApplication {
    static func setupBasicAppTint() {
        shared.keyWindow?.tintColor = BasicProperties.color
    }
}
