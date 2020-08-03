//
//  MFMessageComposeViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 10.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import MessageUI

//MARK: - MFMessageComposeViewController public extension
public extension MFMessageComposeViewController {
    func setupBasicMessageComposer() {
        
        ///Set body
        body = "My Problem: "
        
        ///Set recipients
        recipients = ["+380992776090"]
        
        ///Set tint
        view.tintColor = BasicProperties.color
    }
}
