//
//  UIProgressView.swift
//  GoodBiology
//
//  Created by Yaroslav on 21.12.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

extension UIProgressView {
    
    // Basics Metods for Progress Views
    public func basicProgress() {
        self.setProgress(0, animated: true)
    }
    
    public func startProgress() {
        self.progress += 0.3
    }
    
    public func stopProgress() {
        self.isHidden = true
        
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
