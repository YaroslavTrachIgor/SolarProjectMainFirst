//
//  ContentBack.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 07.02.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ContentBack (Basic View with corners and shadows)

//MARK: ContentBack Protocol
protocol ContentBackProtocol {
    func setupMainContentBackView()
}

class ContentBack: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMainContentBackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupMainContentBackView()
    }
}



//MARK: ContentBackProtocol
extension ContentBack: ContentBackProtocol {
    func setupMainContentBackView() {
        setupBackColor()
        setupCorners()
        viewShadows()
    }
}



//MARK: Main Functions
extension ContentBack {
    private func setupBackColor() {
        backgroundColor = .systemBackground
    }
    
    private func setupCorners() {
        layer.cornerRadius = 20
    }
}
