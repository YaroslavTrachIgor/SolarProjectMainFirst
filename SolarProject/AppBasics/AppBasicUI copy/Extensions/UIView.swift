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
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        
        ///Setup UIBezierPath
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        ///Setup CAShapeLayer
        let mask = CAShapeLayer()
        
        ///Set path
        mask.path = path.cgPath
        
        ///Set mask
        self.layer.mask = mask
    }
}



//MARK: - UIView Gradient extension
extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        
        ///Setup basic gradient
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        
        ///Setup CAGradientLayer
        let gradient: CAGradientLayer = CAGradientLayer()
        
        ///Set gradient frame
        gradient.frame = self.bounds
        
        ///Set gradient colors
        gradient.colors = colours.map { $0.cgColor }
        
        ///Set gradient locations
        gradient.locations = locations
        
        ///Set gradient cornerRadius
        gradient.cornerRadius = BasicProperties.cornerRadius - 2
        
        ///Insert Sublayer
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}



//MARK: - UIView roundCorners extension
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    
        ///Setup UIBezierPath
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    
        ///Setup CAShapeLayer
        let mask = CAShapeLayer()
    
        ///Set path
        mask.path = path.cgPath
    
        ///Set mask
        layer.mask = mask
    }
}
