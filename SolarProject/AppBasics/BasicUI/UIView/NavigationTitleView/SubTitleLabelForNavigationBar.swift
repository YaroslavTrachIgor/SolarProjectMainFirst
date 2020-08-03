//
//  SubTitleLabelForNavigationBar.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 04.03.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

extension SubTitleLabelForNavigationBar {
    
    func setupLabel() {
        textColor = .systemGray
        
        font = UIFont(name: "AvenirNext-Medium", size: 12)
    }
}

class SubTitleLabelForNavigationBar: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel()
    }
}
