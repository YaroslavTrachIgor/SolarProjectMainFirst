//
//  ImagesCollectionViewCell.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 12.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ImagesCollectionViewCell main class
final class ImagesCollectionViewCell: UICollectionViewCell {
    
    //MARK: @IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewBack: UIView!
    @IBOutlet weak var imageViewPreviewBlurView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var planetDetailLabel: UILabel!
    @IBOutlet weak var planetSecondDetailLabel: UILabel!
    
    
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
extension ImagesCollectionViewCell: CollectionViewCellBasicsProtocol {
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
        
        ///Setup contentView
        contentView.layer.cornerRadius = BasicProperties.cornerRadius + 8
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    }
}
