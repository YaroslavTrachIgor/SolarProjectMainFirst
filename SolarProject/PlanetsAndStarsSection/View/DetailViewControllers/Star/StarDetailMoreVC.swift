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

//MARK: - StarDetailDelegate protocol
protocol StarDetailDelegate {
    func setSegue(with id: Int?)
}



//MARK: - StarDetailMoreVC main class
final class StarDetailMoreVC: BasicViewController {
    
    ///Delegate
    var delegate: StarDetailDelegate?
    
    
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
    
    
    //MARK: BasicViewControllerProtocol
    internal func setupBasicViewControllerUI() {
        setupButtons()
        setupNavBar()
        
        ///Setup View
        view.backgroundColor = .systemBackground
    }
}



//MARK: - Main Methods
extension StarDetailMoreVC {
    private func setupButtons() {
        setupThemeButton()
        setupImageButton()
    }
    
    private func setupThemeButton() {
        let tintColor: UIColor = .white
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let imageName = "paperclip"
        let image = UIImage(systemName: imageName, withConfiguration: config)
        let font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        themesButton.imageView?.image = image
        themesButton.setTitleColor(tintColor, for: .normal)
        themesButton.backgroundColor = BasicProperties.color
        themesButton.titleLabel?.font = font
        themesButton.tintColor = tintColor
        themesButton.imageView?.tintColor = tintColor
        themesButton.layer.cornerRadius = 8
        themesButton.buttonsShadows()
    }
    
    
    private func setupImageButton() {
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let imageName = "doc.plaintext"
        let image = UIImage(systemName: imageName, withConfiguration: config)
        let font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        imagesButton.imageView?.image = image
        imagesButton.setTitleColor(.systemIndigo, for: .normal)
        imagesButton.layer.cornerRadius = 8
        imagesButton.backgroundColor = UIColor.TableViewColors.tableViewBackgroundColor
        imagesButton.titleLabel?.font = font
    }
    
    private func setupNavBar() {
        navBar.titleLabel.text = "More"
        setupNavBarRightButton(button: navBar.rightButton)
        view.addSubview(self.navBar)
    }
    
    private func setupNavBarRightButton(button: UIButton) {
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(.systemIndigo, for: .normal)
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
            self.delegate?.setSegue(with: 1)
        })
    }
    
    @IBAction func showThemesVC(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.delegate?.setSegue(with: 2)
        })
    }
}

