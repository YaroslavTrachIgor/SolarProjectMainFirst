//
//  SunImageTableViewCell.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 13.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit

final class SunImageTableViewCell: UITableViewCell {

    //MARK: @IBOutlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var imageBlurView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageViewBlackBack: UIView!
}
