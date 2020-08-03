//
//  UILabel.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: UILabel Shadow public extension
public extension UILabel {
    func setupCollectionViewDetailLabelShadow() {
        labelShadow()
        layer.shadowColor = UIColor.white.cgColor
    }
}
