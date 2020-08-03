//
//  BasicFontChangeSlider.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 30.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - BasicFontChangeSliderProtocol protocol
protocol BasicFontChangeSliderProtocol {
    func setupSlider()
}



//MARK: - BasicFontChangeSlider main class
class BasicFontChangeSlider: UISlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSlider()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupSlider()
    }
}



//MARK: - BasicFontChangeSliderProtocol extension
extension BasicFontChangeSlider: BasicFontChangeSliderProtocol {
    func setupSlider() {
        setupValues()
        setupColors()
    }
}



//MARK: - Main Methods(Private)
extension BasicFontChangeSlider {
    
    //MARK: Setup Values
    private func setupValues() {
        minimumValue = 5
        maximumValue = 30
        
        setupCurrentValue()
    }
    
    private func setupCurrentValue() {
        value = 18
    }
    
    //MARK: Setup Colors
    private func setupColors() {
        thumbTintColor = .white
        minimumTrackTintColor = BasicProperties.color
    }
}
