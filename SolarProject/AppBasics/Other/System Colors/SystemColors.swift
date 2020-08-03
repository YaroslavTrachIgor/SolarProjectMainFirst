//
//  SystemColors.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 15.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    func textSystemBack() {
        if #available(iOS 13.0, *) {
            self.backgroundColor = .tertiaryLabel
        }
    }
    
    func textSystemColor() {
        if #available(iOS 13.0, *) {
            self.textColor = .secondaryLabel
        }
    }
}

extension UILabel {
    func labelSystemBack() {
        if #available(iOS 13.0, *) {
            self.backgroundColor = .tertiaryLabel
        }
    }
    
    func labelSystemColor() {
        if #available(iOS 13.0, *) {
            self.textColor = .secondaryLabel
        }
    }
}

extension UIView {
    public func viewSystemBack() {
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemBackground
        }
    }
}
