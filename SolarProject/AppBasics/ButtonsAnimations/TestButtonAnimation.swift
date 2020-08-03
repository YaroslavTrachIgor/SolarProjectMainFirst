//
//  TestButtonAnimation.swift
//  GoodBiology
//
//  Created by Yaroslav on 11/23/18.
//  Copyright © 2018 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

//MARK: Setup UIButton flash and snake animations
public extension UIButton {
    
    //MARK: Animation for Test buttons
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration          = 0.5
        flash.fromValue         = 1
        flash.toValue           = 0.1
        flash.timingFunction    = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses      = true
        flash.repeatCount       = 1
        
        layer.add(flash, forKey: nil)
    }
    
    func snake() {
        let snake = CABasicAnimation(keyPath: "position")
        snake.duration     = 0.1
        snake.repeatCount  = 2
        snake.autoreverses = true
        
        let fromPoint      = CGPoint(x: center.x - 5, y: center.y)
        let fromValue      = NSValue(cgPoint: fromPoint)
        
        let toPoint        = CGPoint(x: center.x + 5, y: center.y)
        let toValue        = NSValue(cgPoint: toPoint)
        
        snake.fromValue    = fromValue
        snake.toValue      = toValue
        
        layer.add(snake, forKey: nil)
    }
}
