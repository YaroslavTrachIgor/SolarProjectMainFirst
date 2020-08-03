//
//  UIView.swift
//  GoodBiology
//
//  Created by Yaroslav on 21.12.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func viewGradient() {
        // Gradient Bachground for all View Controllers
        
        self.setGradientBackground(colorOne: #colorLiteral(red: 0.9216988683, green: 0.9259644747, blue: 0.936390698, alpha: 1), colorTwo: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    public func viewSizingInPast() {
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }
    
    public func editorsViews() {
        // This views usings in the articles. These views always contains UIStepper or UISwitch.
        self.viewShadows()
        
        self.isHidden           = true
        self.layer.cornerRadius = 12
    }
}



// MARK: - Setup Grdients
extension UIView {
    func setupBasicGadientView() {
        if #available(iOS 13.0, *) {
            self.setGradientBackground(colorOne: .white, colorTwo: .systemGray5)
        }
    }
    
    func setupBasicGadientView(with secondColor: UIColor) {
        if #available(iOS 13.0, *) {
            self.setGradientBackground(colorOne: .white, colorTwo: secondColor)
        }
    }
}



// MARK: - add Tap Gesture To Hide Keyboard
extension UIView {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        addGestureRecognizer(tapGesture)
    }
}
