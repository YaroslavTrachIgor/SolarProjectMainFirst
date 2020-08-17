//
//  RemindersTableViewCell.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - RemindersTableViewCell
final class RemindersTableViewCell: UITableViewCell {
    
    //MARK: @IBOutlets
    @IBOutlet weak var reminderContentBack: ContentBack!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    
    //MARK: @IBOutlets collections
    @IBOutlet var designViews: [UIView]!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCell()
    }
}



//MARK: - RemindersTableViewCell main methods
extension RemindersTableViewCell {
    private func setupCell() {
        backgroundColor = .systemGroupedBackground
    }
}

