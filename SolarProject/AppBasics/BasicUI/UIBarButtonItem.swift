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

extension UIBarButtonItem {
    // Basics for All UIBarButtonItems fot Tests
    
    public func testBarButtonItemsTint() {
        self.tintColor = .biologyGreenColor
    }
    
    public func shareAudio() {
        AudioServicesPlayAlertSound(SystemSoundID(1001))
    }
}


extension UIBarButtonItem {
    typealias BonusAction = (() -> Void)?
    
    func viewShowingWithAnimation(animating view: UIView, main View: UIView,_ bonusAction: BonusAction) {
        View.layoutIfNeeded()
        UIView.animate(withDuration: 0.4) {
            let alpha: CGFloat
            let hidden: Bool
            
            if view.isHidden == true {
                hidden = false
                view.isHidden = hidden
                
                alpha = 1
                view.alpha = alpha
                
                View.layoutIfNeeded()
            } else {
                hidden = true
                view.isHidden = hidden
                
                alpha = 0
                view.alpha = alpha
                
                View.layoutIfNeeded()
            }
        }
        if bonusAction != nil {
            bonusAction!()
        } else { return }
    }
}
