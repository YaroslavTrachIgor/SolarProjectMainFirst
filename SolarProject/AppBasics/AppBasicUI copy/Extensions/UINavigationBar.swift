//
//  UINavigationBar.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: UINavBar Shadow public extension
public extension UINavigationBar {
    func setupBasicShadow(color: CGColor) {
        layer.masksToBounds  = false
        layer.shadowColor    = color
        layer.shadowOpacity  = 0.8
        layer.shadowOffset   = CGSize(width: 0, height: 4.0)
        layer.shadowRadius   = 9
    }
}
