//
//  PersonalAnalyticsTableViewCell.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - PersonalAnalyticsTableViewCell main class
final class PersonalAnalyticsTableViewCell: UITableViewCell {
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var viewsCountBackView: UIView!
    @IBOutlet weak var viewsCountLabel: UILabel!
}
