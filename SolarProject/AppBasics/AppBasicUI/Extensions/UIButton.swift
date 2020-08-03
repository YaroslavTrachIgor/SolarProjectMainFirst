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
        setTitleColor(BasicProperties.color, for: .normal)
        setTitle(title, for: .normal)
        layer.cornerRadius = BasicProperties.cornerRadius
        alpha = 0
        backgroundColor = .systemGroupedBackground
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
}



//MARK: - Setup pulse animation
//MARK: Notification Button (UIButton) setup animation
extension UIButton {
    public func addNotificationButtonPulse(view: UIView) {
        let pulse = Pulsing(numberOfPulses: 2, radius: 200, position: self.center)
        
        pulse.animationDuration = 0.9
        pulse.backgroundColor = BasicProperties.color.cgColor
        
        view.layer.insertSublayer(pulse, below: self.layer)
    }
    
    public func setupBasicPlanetCellButton() {
        layer.cornerRadius = BasicProperties.cornerRadius
        layer.borderColor = BasicProperties.color.cgColor
        layer.borderWidth = 1.3
        titleLabel?.font = UIFont.systemFont(ofSize: 11.5, weight: .semibold)
        setTitleColor(BasicProperties.color, for: .normal)
        buttonsShadows()
    }
}
