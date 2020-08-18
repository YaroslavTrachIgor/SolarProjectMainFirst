//
//  UIView.swift
//  SolarProject
//
//  Created by Yaroslav on 01.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIView extension
public extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let mask = CAShapeLayer()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}



//MARK: - UIView Gradient extension
public extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        
        ///Setup basic gradient
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        
        ///Setup CAGradientLayer
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.cornerRadius = BasicProperties.cornerRadius - 2
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}



//MARK: - UIView roundCorners extension
public extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let mask = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        mask.path = path.cgPath
        layer.mask = mask
    }
}
