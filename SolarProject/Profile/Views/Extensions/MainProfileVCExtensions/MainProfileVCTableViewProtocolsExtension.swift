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
        return setupNumberOfRowsInSection()
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        ///Setup number Of Rows In Section
        return setupNumberOfSections(section: section)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell")!
        
        ///Setup cell
        setupCellTitles(cell: cell, indexPath: indexPath)
        
        ///Set cell label shedow
        cell.textLabel?.labelShadow()
        cell.textLabel?.layer.shadowRadius = 0.5
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        ///Setup Sections Headers
        return setupSectionHeaders(section: section)
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ///Setup Segues
        setupSegues(indexPath: indexPath)
    }
}
