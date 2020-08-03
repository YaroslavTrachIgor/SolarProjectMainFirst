//
//  UISegmentedControl.swift
//  GoodBiology
//
//  Created by Yaroslav on 21.12.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

fileprivate protocol SegmentedControlBasics {
    func segConBasicView()
}

extension UISegmentedControl: SegmentedControlBasics {
    
    public func segmentedControlBasics() {
        self.alpha = 0
        
        segConBasicView()
    }
    
    public func segmentedControlForToday() {
        segConBasicView()
    }
    
    public func segConBasicView() {
        self.segmentedControlShadow()
        
        self.tintColor = .orange
        
        self.layer.cornerRadius  = 25
        self.layer.masksToBounds = true
        
        let font  = UIFont(name: "AvenirNext-DemiBold", size: 12)
        self.setTitleTextAttributes([NSAttributedString.Key.font: font!], for: .normal)
    }
}
