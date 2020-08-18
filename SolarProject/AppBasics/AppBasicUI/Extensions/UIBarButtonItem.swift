//
//  UIBarButtonItem.swift
//  GoodBiology
//
//  Created by Yaroslav on 21.12.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

//MARK: - Setup UIBarButtonItem basics
public extension UIBarButtonItem {
    // Basics for All UIBarButtonItems fot Tests
    
    func testBarButtonItemsTint() {
        self.tintColor = BasicProperties.color
    }
    
    //Setup Share Audio
    func shareAudio() {
        AudioServicesPlayAlertSound(SystemSoundID(1001))
    }
}


public extension UIBarButtonItem {
    typealias BonusAction = (() -> Void)?
    
    func viewShowingWithAnimation(animating view: UIView, main View: UIView,_ bonusAction: BonusAction) {
        View.layoutIfNeeded()
        UIView.animate(withDuration: 0.4) {
            let alpha: CGFloat
            let hidden: Bool
            let scaleXY: CGFloat
            
            if view.isHidden == true {
                hidden = false
                view.isHidden = hidden
                
                alpha = 1
                view.alpha = alpha
                
                scaleXY = 1
                view.transform = CGAffineTransform(scaleX: scaleXY, y: scaleXY)
                
                View.layoutIfNeeded()
            } else {
                hidden = true
                view.isHidden = hidden
                
                alpha = 0
                view.alpha = alpha
                
                scaleXY = 0
                view.transform = CGAffineTransform(scaleX: scaleXY, y: scaleXY)
                
                View.layoutIfNeeded()
            }
        }
        if bonusAction != nil {
            bonusAction!()
        } else { return }
    }
}
