//
//  StarDetailMoreVC.swift
//  SolarProject
//
//  Created by Yaroslav on 27.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import SPFakeBar
import SPStorkController

//MARK: - StarDetailMoreVC main class
final class StarDetailMoreVC: BasicViewController {
    
    //MARK: Private
    private let navBar = SPFakeBarView(style: .stork)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: @IBOutlets
    @IBOutlet weak var imagesButton: UIButton!
    @IBOutlet weak var themesButton: UIButton!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBasicViewControllerUI()
    }
    
    func setupBasicViewControllerUI() {
        setupButtons()
        setupNavBar()
    }
}



//MARK: - Main Methods
extension StarDetailMoreVC {
    private func setupButtons() {
        setupThemeButton()
        setupImageButton()
    }
    
    private func setupThemeButton() {
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        themesButton.imageView?.image = UIImage(systemName: "paperclip", withConfiguration: config)
        themesButton.setTitleColor(.systemIndigo, for: .normal)
        themesButton.layer.cornerRadius = 8
        themesButton.backgroundColor = .systemGroupedBackground
        themesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    
    private func setupImageButton() {
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        themesButton.imageView?.image = UIImage(systemName: "doc.plaintext", withConfiguration: config)
        imagesButton.layer.cornerRadius = 8
        imagesButton.setTitleColor(.systemIndigo, for: .normal)
        imagesButton.backgroundColor = .systemGroupedBackground
        imagesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    private func setupNavBar() {
        
        ///Setup titleLabel
        navBar.titleLabel.text = "MORE"
        
        ///Setup rightButton
        navBar.rightButton.setTitle("Cancel", for: .normal)
        navBar.rightButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        navBar.rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        navBar.rightButton.setTitleColor(.systemIndigo, for: .normal)

        view.addSubview(self.navBar)
    }
    
    
    //MARK: @objc
    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
}



//MARK: - @IBActions
extension StarDetailMoreVC {
    @IBAction func showImagesVC(_ sender: Any) {
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ImagesShowVCNotificationName"), object: nil)
        })
    }
    
    @IBAction func showThemesVC(_ sender: Any) {
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ThemesShowVCNotificationName"), object: nil)
        })
    }
}

