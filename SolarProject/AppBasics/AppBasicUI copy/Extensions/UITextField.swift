//
//  UITextField.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: UITextField public extension
public extension UITextField {
    func setupBasicSearchBar() {
        
        ///Set cornerRadiuses
        layer.cornerRadius = BasicProperties.cornerRadius
        
        ///Set colors
        textColor = .black
        tintColor = BasicProperties.color
        
        ///Set font
        font = UIFont(name: "AvenirNext-Medium", size: 15)

        ///Set masksToBounds
        layer.masksToBounds = true
        
        ///Set KeyType
        returnKeyType = .search
    }
}
