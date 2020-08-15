//
//  PlanetImageViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 29.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import SPAlert

//MARK: - PlanetImageViewController main class
final class PlanetImageViewController: UIViewController {
    
    //MARK: Public
    public var image: UIImage?
    
    //MARK: @IBOutlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageViewImage()
        setupShareButton()
        setupDismissButton()
    }
}



//MARK: - @IBActions
extension PlanetImageViewController {
    @IBAction func shareImage(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        activityVC.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                
                ///Setup successfull Alert
                let alert = SPAlertView(title: "Image saved", message: "Image was successfully saved to your photo library.", preset: .done)
                alert.duration = 2
                alert.present()
            }
        }
        present(activityVC, animated: true)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}



//MARK: - Main methods
private extension PlanetImageViewController {
    private func setupImageViewImage() {
        mainImageView.image = image
    }
    
    private func setupDismissButton() {
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "multiply", withConfiguration: config)
        dismissButton.setImage(image, for: .normal)
        dismissButton.layer.cornerRadius = dismissButton.frame.height / 2
    }
    
    private func setupShareButton() {
        let config = UIImage.SymbolConfiguration(weight: .medium)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: config)
        shareButton.setImage(image, for: .normal)
        shareButton.imageView?.tintColor = BasicProperties.color
        shareButton.backgroundColor = #colorLiteral(red: 0.1118186724, green: 0.1118186724, blue: 0.1118186724, alpha: 1)
        shareButton.layer.cornerRadius = BasicProperties.cornerRadius
        shareButton.setTitleColor(BasicProperties.color, for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        shareButton.setTitle("  Share Image", for: .normal)
    }
}
