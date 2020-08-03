//
//  NewsCell.swift
//  SolarProject
//
//  Created by Yaroslav on 28.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - NewsCell main class
final class NewsCell: UITableViewCell {
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentBack: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
}
