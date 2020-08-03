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
        layer.cornerRadius = BasicProperties.cornerRadius
        textColor = .black
        tintColor = BasicProperties.color
        font = UIFont.systemFont(ofSize: 15, weight: .medium)
        layer.masksToBounds = true
        returnKeyType = .search
    }
    
    func setupBasicAccountTextField() {
        tintColor = BasicProperties.color
        font = .systemFont(ofSize: 15, weight: .medium)
    }
}
