//
//  ContentTextView.swift
//  SolarProject
//
//  Created by Yaroslav on 11.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ContentTextView main class
final class ContentTextView: UITextView {
    
    //MARK: Inits
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupTextView()
    }
    
    
    //MARK: Private
    private func setupTextView() {
        setupTextFont()
        setupTextViewBasics()
    }
    
    private func setupTextFont() {
        textColor = #colorLiteral(red: 0.2190820516, green: 0.2190820516, blue: 0.2190820516, alpha: 1)
        font = UIFont.systemFont(ofSize: 19, weight: .regular)
    }
    
    private func setupTextViewBasics() {
        isEditable = false
        isSelectable = true
        
        ///Set cornerRadius
        layer.cornerRadius = BasicProperties.cornerRadius
        
        ///Set alpha
        alpha = 1
    }
}
