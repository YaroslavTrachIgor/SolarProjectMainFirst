//
//  NavigationTitleView.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 07.02.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation
import UIKit

protocol BasicUINavigationItemProtocol {
    func setTitleText(titleLabel: UILabel, subtitleLabel: UILabel, title: String, subTitle: String)
    func setupStackView(stackView: UIStackView)
}

extension UINavigationItem: BasicUINavigationItemProtocol {
    func setTitleText(titleLabel: UILabel, subtitleLabel: UILabel, title: String, subTitle: String) {
        titleLabel.text    = title
        subtitleLabel.text = subTitle
    }
    
    func setupStackView(stackView: UIStackView) {
        stackView.distribution  = .equalCentering
        stackView.alignment     = .center
        stackView.axis          = .vertical
        
        self.titleView = stackView
    }
}

extension UINavigationItem {
    func setTitle(_ title: String, subtitle: String) {
        /// Titles
        let titleLabel      = TitleLabelForNavigationBar()
        let subtitleLabel   = SubTitleLabelForNavigationBar()
        
        /// StackView
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])

        // Setup StackView
        setupStackView(stackView: stackView)
        
        // Setup Title Labels
        setTitleText(titleLabel: titleLabel, subtitleLabel: subtitleLabel, title: title, subTitle: subtitle)
    }
}
