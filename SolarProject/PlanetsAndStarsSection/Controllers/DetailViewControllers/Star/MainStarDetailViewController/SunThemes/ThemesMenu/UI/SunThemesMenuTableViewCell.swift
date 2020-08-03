//
//  SunThemesMenuTableViewCell.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 31.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - SunThemesMenuTableViewCell main class
class SunThemesMenuTableViewCell: UITableViewCell {
    
    //MARK: Private
    private let basicCellCornerRadius: CGFloat = 8
    
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewTextView: UITextView! {
        didSet {
            previewTextView.layer.cornerRadius = basicCellCornerRadius
            
            ///Setup Properties
            let security = false
            previewTextView.isSelectable     = security
            previewTextView.isScrollEnabled  = security
            previewTextView.isEditable       = security
        }
    }
    @IBOutlet weak var previewContentBack: ContentBack! { didSet { previewContentBack.layer.cornerRadius = basicCellCornerRadius; } }
}
