//
//  UIViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 09.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

//MARK: - UIViewController extension
public extension UIViewController {
    
    //MARK: Func for set Tab Bar hidden
    func setTabBarHidden(_ hidden: Bool) {
        tabBarController?.tabBar.isHidden = hidden
    }
    
    
    //MARK: Func for fast SafariVC showing
    func showSafariVC(with stringURL: String) {
        if let url = URL(string: stringURL) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            vc.preferredControlTintColor = BasicProperties.color
            present(vc, animated: true)
        }
    }
}
