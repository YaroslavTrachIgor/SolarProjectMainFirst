//
//  UILabel.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

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



//MARK: - UILabel public extension
public extension UILabel {
    
    //MARK: UILabel Cell setup
    func setupBasicCellLabel(text: String?) {
        let font = UIFont.systemFont(ofSize: 15, weight: .medium)
        let color: UIColor = .label
        self.text = text
        textColor = color
        alpha = 1
        isHidden = false
        self.font = font
    }
    
    
    //MARK: Setup Profile Detail UILabel
    func setupBasicProfileDetailLabel(text: String?) {
        self.text = text
        font = UIFont.systemFont(ofSize: 12, weight: .medium)
        textColor = .secondaryLabel
        alpha = 1
    }
    
    //MARK: UILabel Shadow public extension
    func setupCollectionViewDetailLabelShadow() {
        labelShadow()
        layer.shadowColor = UIColor.white.cgColor
    }
}
