//
//  UIViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 09.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIViewController extension
public extension UIViewController {
    func setTabBarHidden(_ hidden: Bool) {
        tabBarController?.tabBar.isHidden = hidden
    }
}
