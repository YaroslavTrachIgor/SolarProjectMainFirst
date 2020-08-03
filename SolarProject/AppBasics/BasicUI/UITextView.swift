//
//  UITextView.swift
//  GoodBiology
//
//  Created by Yaroslav on 21.12.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    public func switchTextViewPrefering() {
        self.isSelectable = false
        self.isEditable = false
        
        self.text = "Hide diffrent functions"
        self.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        
        self.systemTextColor()
        self.textViewShadow()
    }
    
    public func systemTextColor() {
        if #available(iOS 13.0, *) {
            self.textColor = .secondaryLabel
        }
    }
}

extension UITextView {
    
    // Basics for Text Views
    public func mainTextViewTextColor(alpha: Float) {
        self.textColor  = .darkGray
        self.tintColor  = .orange
        self.alpha      = CGFloat(alpha)
    }
    
    public func textViewBorder() {
        self.layer.borderWidth = 1.2
        self.layer.borderColor = #colorLiteral(red: 0.6476632953, green: 0.6438156962, blue: 0.6506224871, alpha: 1)
    }
    
    public func bigContentTextViewsPrefering(size: Float) {
        self.isEditable   = false
        self.isSelectable = false
        
        self.alpha = 0
        self.font  = UIFont(name: "AvenirNext-Medium", size: CGFloat(size))
        
        self.textViewShadow()
    }
}
