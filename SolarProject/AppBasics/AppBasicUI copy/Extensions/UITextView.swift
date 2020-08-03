//
//  UITextView.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 10.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITextView public extension
public extension UITextView {
    func setupContentWithAnimation(text: String) {
        UIView.transition(with: self,
             duration: 0.25,
              options: .transitionCrossDissolve,
           animations: {
               self.text = text
        }, completion: nil)
    }
}

