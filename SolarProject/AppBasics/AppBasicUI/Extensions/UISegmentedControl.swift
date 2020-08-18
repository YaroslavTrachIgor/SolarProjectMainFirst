//
//  UISegmentedControl.swift
//  GoodBiology
//
//  Created by Yaroslav on 21.12.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

//MARK: SegmentedControlBasics protocol
fileprivate protocol SegmentedControlBasics {
    func segConBasicView()
}



//MARK: SegmentedControlBasics extension
extension UISegmentedControl: SegmentedControlBasics {
    func segmentedControlBasics() {
        alpha = 0
        segConBasicView()
    }
    
    func segmentedControlForToday() {
        
        ///Setup Basics
        segConBasicView()
    }
    
    func segConBasicView() {
        segmentedControlShadow()
        tintColor = BasicProperties.color
        layer.cornerRadius  = BasicProperties.cornerRadius
        layer.masksToBounds = true
        
        ///Set font
        let attr = NSDictionary(object: UIFont.systemFont(ofSize: 12.5, weight: .semibold), forKey: NSAttributedString.Key.font as NSCopying)
        setTitleTextAttributes(attr as? [NSAttributedString.Key : Any], for: .normal)
    }
}
