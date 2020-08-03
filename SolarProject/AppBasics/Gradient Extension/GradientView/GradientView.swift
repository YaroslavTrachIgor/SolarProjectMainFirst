//
//  GradientView.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 30.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    //MARK: - Properties
    public let gradientLayer = CAGradientLayer()
    
    
    //MARK: - @IBInspectable private Properties
    @IBInspectable private var startColor: UIColor? { didSet { setupGradient(); } }
    @IBInspectable private var middleColor: UIColor? { didSet { setupGradient(); } }
    @IBInspectable private var endColor: UIColor? { didSet { setupGradient(); } }
    
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupGradient()
    }
    
    
    //MARK: - Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
}



//MARK: Private methods are here
extension GradientView {
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        self.layer.cornerRadius = 4
        
        setupGradientColors()
    }
    
    
    private func setupGradientColors() {
        if let startColor = startColor, let endColor = endColor, let middleColor = middleColor {
            gradientLayer.colors = [startColor.cgColor, middleColor.cgColor, endColor.cgColor]
        }
    }
}
