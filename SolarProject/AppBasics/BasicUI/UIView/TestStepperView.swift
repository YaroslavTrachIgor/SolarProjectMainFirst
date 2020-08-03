//
//  TestStepperView.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 07.02.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

class TestStepperView: StepperView {
    override init(frame: CGRect) {
      super.init(frame: frame)
        setupTestStepperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        setupTestStepperView()
    }
    
    private func setupTestStepperView() {
        isHidden = true
        
        layer.shadowColor  = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowRadius = 8.4
    }
}
