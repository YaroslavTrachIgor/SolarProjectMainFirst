//
//  BasicViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 02.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - BasicViewControllerProtocol
protocol BasicViewControllerProtocol {
    func setupBasicViewControllerUI()
}



//MARK: - BasicViewController typealias
typealias BasicViewController = UIViewController & BasicViewControllerProtocol
