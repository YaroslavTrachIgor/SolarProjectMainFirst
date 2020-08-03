//
//  UISwitch.swift
//  GoodBiology
//
//  Created by Yaroslav on 21.12.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

extension UISwitch {
    public func switchBasics() {
        
        /// Basics for UISwitch
        self.isOn               = true
        self.layer.cornerRadius = 1
        
        /// Colors
        self.thumbTintColor     = .white
        self.onTintColor        = .orange
        
        self.switchShadow()
    }
}
