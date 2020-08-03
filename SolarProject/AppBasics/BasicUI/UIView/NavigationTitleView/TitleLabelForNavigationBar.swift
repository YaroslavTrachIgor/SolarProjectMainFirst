//
//  TitleLabelForNavigationBar.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 04.03.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

extension TitleLabelForNavigationBar {
    
    func setupLabel() {
        textColor = .white
        
        font = UIFont(name: "AvenirNext-DemiBold", size: 15.4)
    }
}

class TitleLabelForNavigationBar: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel()
    }
}
