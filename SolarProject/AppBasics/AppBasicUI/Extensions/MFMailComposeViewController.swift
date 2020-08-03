//
//  MFMailComposeViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 10.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import MessageUI

//MARK: - MFMailComposeViewController public extension
public extension MFMailComposeViewController {
    func setupBasicMailComposer() {
        setToRecipients(["zhbr282@gmail.com"])
        setSubject("Tests Review")
        setMessageBody("Here is my problem or review on this app article or articles", isHTML: false)
        view.tintColor = BasicProperties.color
    }
}
