//
//  FastAlert.swift
//  GoodBiology
//
//  Created by Yaroslav on 22.01.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Fast Alert Maneger main class
public final class AlertManeger {
    typealias Action = () -> Void
    static func presentAlert(title: String?, message: String?, vc: UIViewController) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.view.tintColor = BasicProperties.color
        alertVC.addAction(okAction)
        vc.present(alertVC, animated: true)
    }
}

