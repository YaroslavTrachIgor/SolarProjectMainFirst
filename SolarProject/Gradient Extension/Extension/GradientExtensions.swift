//
//  GradientExtensions.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 1/5/19.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIView Gradient Extensions
extension UIView {
    
    //MARK: Public
    public func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame         = bounds
        gradientLayer.colors        = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations     = [0.0, 1.0]
        gradientLayer.startPoint    = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint      = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    public func setTestGradientBackground(colorOne: UIColor, colorTwo: UIColor, colorThird: UIColor, colorForth: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame         = bounds
        gradientLayer.colors        = [colorOne.cgColor, colorTwo.cgColor, colorThird.cgColor, colorForth.cgColor]
        gradientLayer.locations     = [0.0, 1.0]
        gradientLayer.startPoint    = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint      = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
