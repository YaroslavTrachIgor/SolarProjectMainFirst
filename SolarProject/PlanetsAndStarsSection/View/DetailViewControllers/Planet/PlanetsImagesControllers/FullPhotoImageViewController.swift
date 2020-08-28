//
//  FullPhotoImageViewController.swift
//  SolarProject
//
//  Created by Yaroslav on 27.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - FullPhotoImageViewController main class
final class FullPhotoImageViewController: BasicViewController {
    
    //MARK: Internal
    internal var imageView: UIImageView!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setup UI
        setupBasicViewControllerUI()
    }
    
    
    //MARK: BasicViewController protocol
    internal func setupBasicViewControllerUI() {
        view.backgroundColor = .black
        setupImageView()
    }
    

    //MARK: Private
    private func setupImageView() {
        let image = FullPhotoImageSingletone.shared.image
        imageView = UIImageView()
        view.addSubview(imageView)
        imageView.frame = view.frame
        imageView.alpha = 1
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
}
