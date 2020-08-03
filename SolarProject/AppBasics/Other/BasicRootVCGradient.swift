//
//  BasicRootVCGradient.swift
//  GoodBiology
//
//  Created by Yaroslav on 09.03.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

class BasicRootVCGradient: NSObject {
    
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
    }
    
    func setupRootViewsWithBasicGradient(mainView: UIView, scrollView: UIScrollView?) {
        scrollView?.setupBasicGadientView(with: color)
        mainView.setupBasicGadientView(with: color)
    }
}
