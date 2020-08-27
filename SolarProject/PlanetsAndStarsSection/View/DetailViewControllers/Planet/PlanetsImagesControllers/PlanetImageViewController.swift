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
final class PlanetImageViewController: BasicViewController {
    
    //MARK: Public
    public var image: UIImage?
    
    
    //MARK: @IBOutlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setup UI
        setupBasicViewControllerUI()
        registerForPreviewing(with: self, sourceView: view)
    }
    
    
    //MARK: BasicViewController protocol
    internal func setupBasicViewControllerUI() {
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
    func setupImageViewImage() {
        mainImageView.image = image
    }
    
    func setupDismissButton() {
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "multiply", withConfiguration: config)
        let cornerRadius = dismissButton.frame.height / 2
        dismissButton.setImage(image, for: .normal)
        dismissButton.layer.cornerRadius = cornerRadius
    }
    
    func setupShareButton() {
        let config = UIImage.SymbolConfiguration(weight: .medium)
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: config)
        let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        let cornerRadius = BasicProperties.cornerRadius
        let tintColor = BasicProperties.color
        let title = "  Share Image"
        shareButton.setImage(image, for: .normal)
        shareButton.imageView?.tintColor = tintColor
        shareButton.backgroundColor = #colorLiteral(red: 0.1118186724, green: 0.1118186724, blue: 0.1118186724, alpha: 1)
        shareButton.layer.cornerRadius = cornerRadius
        shareButton.setTitleColor(tintColor, for: .normal)
        shareButton.titleLabel?.font = font
        shareButton.setTitle(title, for: .normal)
    }
}



//MARK: - UIViewControllerPreviewingDelegate extension
extension PlanetImageViewController: UIViewControllerPreviewingDelegate {
    internal func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let vc = FullPhotoImageViewController()
        let size = CGSize(width: view.frame.width * 0.8, height: view.frame.height * 0.8)
        vc.preferredContentSize = size
        FullPhotoImageSingletone.shared.image = mainImageView.image!
        previewingContext.sourceRect = mainImageView.frame
        return vc
    }
    
    internal func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}
