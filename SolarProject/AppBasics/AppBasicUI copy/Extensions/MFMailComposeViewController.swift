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
        
        ///Set to Recipients
        setToRecipients(["zhbr282@gmail.com"])
        
        ///Set Subject
        setSubject("Tests Review")
        
        ///Set Message Body
        setMessageBody("Here is my problem or review on this app article or articles", isHTML: false)
        
        ///Set tintColor
        view.tintColor = BasicProperties.color
    }
}
