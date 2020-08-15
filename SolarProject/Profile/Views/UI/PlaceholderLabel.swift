//
//  PlaceholderLabel.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 15.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: PlaceholderLabel main class
final class PlaceholderLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLabel()
    }
}



//MARK: PlaceholderLabel main methods
extension PlaceholderLabel {
    private func setupLabel() {
        textColor = .systemGray3
        font = UIFont.systemFont(ofSize: 9, weight: .semibold)
    }
}
