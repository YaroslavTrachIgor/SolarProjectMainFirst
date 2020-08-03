//
//  ActivityVCManeger.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 29.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

class ActivityVCManeger {
    static func showBasic(content: String, for vc: UIViewController) {
        let activityVC = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        vc.present(activityVC, animated: true)
    }
}
