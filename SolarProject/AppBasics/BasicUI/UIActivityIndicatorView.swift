//
//  File.swift
//  GoodBiology
//
//  Created by Yaroslav on 21.12.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    
    // Basics for Activity Indicator
    public func activityIndicatorStarts(colorOfActivity: UIColor) {
        self.hidesWhenStopped   = true
        self.color              = colorOfActivity
        self.startAnimating()
    }
    
    public func activityIndicatorStop() {
        self.stopAnimating()
        self.isHidden = true
    }
}
