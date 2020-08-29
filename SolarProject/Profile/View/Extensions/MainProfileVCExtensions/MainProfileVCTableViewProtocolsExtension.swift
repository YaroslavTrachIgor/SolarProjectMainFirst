//
//  MainProfileVCTableViewProtocolsExtension.swift
//  SolarProject
//
//  Created by Yaroslav on 28.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainProfileViewController: UITableViewDelegate, UITableViewDataSource {
    internal func numberOfSections(in tableView: UITableView) -> Int {
        
        ///Setup number Of Sections
        return presenter.setupNumberOfRowsInSection()
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        ///Setup number Of Rows In Section
        return presenter.setupNumberOfSections(section: section)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell")!
        
        ///Setup basic cell
        ///(for userAccaunt, applicationInfo, settings section)
        func setupBasicCell() {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16.5, weight: .semibold)
            cell.textLabel?.textColor = .label
        }
        
        ///Setup button cell
        ///(for permissions and support cell)
        func setupButtonCell() {
            cell.accessoryType = .none
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16.5, weight: .regular)
            cell.textLabel?.textColor = BasicProperties.color
            cell.imageView?.image = nil
        }
        
        
        ///Setup cell imageView
        let section = sections[indexPath.section]
        if section != .permissions {
            cell.imageView?.image = UIImage(systemName: presenter.setupImagesNames(section: indexPath.section, row: indexPath.row)!)
            cell.imageView?.tintColor = presenter.setupImagesTintColors(section: indexPath.section, row: indexPath.row)
        }
        
        ///Setup cell
        switch section {
        case .userAccaunt: setupBasicCell()
        case .applicationInfo: setupBasicCell()
        case .settings: setupBasicCell()
        case .permissions: setupButtonCell()
        }
        
        ///Setup basic cell
        let backColor: UIColor = .systemBackground
        cell.backgroundColor = backColor
        cell.contentView.backgroundColor = backColor
        cell.tintColor = BasicProperties.color
        cell.textLabel?.text = presenter.setupLabelsText(section: indexPath.section, row: indexPath.row)
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        ///Setup Sections Headers
        return presenter.setupSectionHeaders(section: section)
    }
    
    internal func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return presenter.setupSectionFooters(section: section)
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ///Setup Segues
        setupSegues(indexPath: indexPath)
    }
}
