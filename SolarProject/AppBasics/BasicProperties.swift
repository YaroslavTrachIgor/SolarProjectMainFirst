//
//  BasicProperties.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 26.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Basic Properties struct
public struct BasicProperties {
    
    //MARK: Basic cornerRadius
    ///CGFloat
    static let cornerRadius: CGFloat = 9.5
    
    //MARK: Basic color
    ///UIColor
    static var color: UIColor = defaults.object(forKey: "BasicPropertiesColorKey") as? UIColor ?? .systemIndigo
}
