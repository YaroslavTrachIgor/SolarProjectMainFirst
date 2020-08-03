//
//  RefreshControl.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 09.01.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

//MARK: - BasicRefreshControl protocol
final class BasicRefreshControl: UIRefreshControl {
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addTarget()
    }
    
    //MARK: - Overrides
    override init() {
        super.init()
        
        addTarget()
    }
}



//MARK: Main Methods
extension BasicRefreshControl {
    private func addTarget() {
        
        ///Setup control hidden
        addTarget(self, action: #selector(UIRefreshControl.endRefreshing), for: .valueChanged)
        
        ///Setup tintColor
        tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        ///Setup Shadow
        layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.8
    }
}
