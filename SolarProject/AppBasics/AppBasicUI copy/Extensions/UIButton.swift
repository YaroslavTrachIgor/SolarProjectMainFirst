//
//  UIButton.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 13.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Setup article detail button basics extension
public extension UIButton {
    func setupArticleDetailButton(title: String) {
        
        ///Set titleColor
        setTitleColor(BasicProperties.color, for: .normal)
        
        ///Set title
        setTitle(title, for: .normal)
        
        ///Set corners
        layer.cornerRadius = BasicProperties.cornerRadius
        
        ///Set alpha
        alpha = 0
        
        ///Setup Shadow
        addSoftUIEffectForButton()
        
        ///Set backgroundColor
        backgroundColor = .systemGroupedBackground
        
        ///Set font
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
        ///Setup titleLabel shadow
        titleLabel?.labelShadow()
        titleLabel?.layer.shadowColor = BasicProperties.color.cgColor
    }
}
