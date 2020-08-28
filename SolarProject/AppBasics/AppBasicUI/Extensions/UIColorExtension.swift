//
//  UIColor.swift
//  SolarProject
//
//  Created by Yaroslav on 17.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIColor public extension
public extension UIColor {
    
    //MARK: TableViewColors
    struct TableViewColors {
        static var tableViewSeparatorColor: UIColor {
            return #colorLiteral(red: 0.9228869558, green: 0.9228869558, blue: 0.9228869558, alpha: 1)
        }
        
        static var tableViewBackgroundColor: UIColor {
            return .systemGroupedBackground
        }
    }
}
