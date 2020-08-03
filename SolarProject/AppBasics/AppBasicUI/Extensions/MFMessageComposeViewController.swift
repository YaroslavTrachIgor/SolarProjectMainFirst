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
        body = "My Problem: "
        recipients = ["+380992776090"]
        view.tintColor = BasicProperties.color
    }
}
