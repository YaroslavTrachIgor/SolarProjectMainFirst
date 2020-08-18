//
//  UITextView.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 10.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - TextViewsContentApdateSetupProtocol protocol
protocol TextViewsContentApdateSetupProtocol {
    func setupContentWithAnimation(text: String)
}



//MARK: - UITextView public extension
//MARK: TextViewsContentApdateSetupProtocol extension
extension UITextView: TextViewsContentApdateSetupProtocol {
    internal  func setupContentWithAnimation(text: String) {
        UIView.transition(with: self,
             duration: 0.25,
              options: .transitionCrossDissolve,
           animations: {
            self.text = text
        }, completion: nil)
    }
}

