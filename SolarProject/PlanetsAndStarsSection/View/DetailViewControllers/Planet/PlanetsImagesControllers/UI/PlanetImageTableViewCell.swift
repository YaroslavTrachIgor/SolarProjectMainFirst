//
//  PlanetImageTableViewCell.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 13.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit

//MARK: - PlanetImageCollectionViewCell main class
final class PlanetImageCollectionViewCell: UICollectionViewCell {

    //MARK: @IBOutlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var imageBlurView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageViewBlackBack: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupContentView()
        setupShadow()
    }
}



//MARK: - CollectionViewCellBasicsProtocol extension
extension PlanetImageCollectionViewCell: CollectionViewCellBasicsProtocol {
    internal func setupShadow() {
        
        ///Setup shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    internal func setupContentView() {
        
        ///Set cornarRadius
        layer.cornerRadius = BasicProperties.cornerRadius + 5
        
        ///Setup contentView
        contentView.layer.cornerRadius = BasicProperties.cornerRadius + 5
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    }
}
