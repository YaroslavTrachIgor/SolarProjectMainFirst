//
//  loginButtonAnimatiol.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 3/2/19.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

//MARK: Setup UIButton shake animation
public extension UIButton {
    func shake(horizantaly: CGFloat = 0 , Verticaly: CGFloat = 0) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - horizantaly, y: self.center.y - Verticaly ))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + horizantaly, y: self.center.y + Verticaly ))
        
        self.layer.add(animation, forKey: "position")
    }
}
