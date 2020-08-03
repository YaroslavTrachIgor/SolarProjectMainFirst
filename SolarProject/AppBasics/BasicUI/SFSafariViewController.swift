//
//  SFSafariViewController.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 09.01.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import SafariServices
import UIKit

protocol BasicSafariVCProtocol {
    func preferringBarTintColor()
    func preferringControlTintColor()
}

class BasicSafariVC: SFSafariViewController {
    func setupSafariVC() {
        preferringBarTintColor()
        preferringControlTintColor()
    }
}

extension BasicSafariVC: BasicSafariVCProtocol {
    func preferringBarTintColor() {

        /// It can't be 'lazyColor'
        preferredBarTintColor = .orange
    }
    
    func preferringControlTintColor() {
        preferredControlTintColor = .white
    }
}
