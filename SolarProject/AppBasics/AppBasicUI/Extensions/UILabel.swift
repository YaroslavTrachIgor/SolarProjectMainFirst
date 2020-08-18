//
//  UILabel.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: UILabel Shadow public extension
public extension UILabel {
    func setupCollectionViewDetailLabelShadow() {
        labelShadow()
        layer.shadowColor = UIColor.white.cgColor
    }
}



//MARK: - UITextView public extension(change text with animation)
extension UILabel: TextViewsContentApdateSetupProtocol {
    typealias ContentView = UILabel
    
    internal func setupContentWithAnimation(text: String) {
        UIView.transition(with: self,
             duration: 0.25,
              options: .transitionCrossDissolve,
           animations: {
               self.text = text
        }, completion: nil)
    }
}



//MARK: - UILabel Cell setup
public extension UILabel {
    func setupBasicCellLabel(text: String?) {
        let font = UIFont.systemFont(ofSize: 15, weight: .medium)
        let color: UIColor = .black
        self.text = text
        textColor = color
        alpha = 1
        isHidden = false
        self.font = font
    }
}
