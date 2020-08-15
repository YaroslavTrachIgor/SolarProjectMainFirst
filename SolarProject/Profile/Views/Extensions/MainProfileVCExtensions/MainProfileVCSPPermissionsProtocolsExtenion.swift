//
//  MainProfileVCSPPermissionsProtocolsExtenion.swift
//  SolarProject
//
//  Created by Yaroslav on 28.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import SPPermissions

//MARK: - SPPermissionsDelegate, SPPermissionsDataSource extension
extension MainProfileViewController: SPPermissionsDelegate, SPPermissionsDataSource {
    func configure(_ cell: SPPermissionTableViewCell, for permission: SPPermission) -> SPPermissionTableViewCell {
        
        ///Setup allowed button
        cell.button.allowedBackgroundColor = BasicProperties.color
        cell.button.allowedTitleColor = .white
        
        ///Setup allow button
        cell.button.allowTitleColor = BasicProperties.color
        cell.button.allowBackgroundColor = .systemGroupedBackground
        
        ///Setup iconView
        cell.iconView.color = BasicProperties.color
        
        return cell
    }
}
