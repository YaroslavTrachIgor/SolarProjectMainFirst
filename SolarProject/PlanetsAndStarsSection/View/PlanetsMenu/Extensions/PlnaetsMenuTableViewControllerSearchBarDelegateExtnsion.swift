//
//  PlnaetsMenuTableViewControllerSearchBarDelegateExtnsion.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UISearchBarDelegate
extension PlanetsMenuTableViewController: UISearchBarDelegate {
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let semaphore = DispatchSemaphore(value: 1)
        let mainQueue = DispatchQueue.main
        
        DispatchQueue.global().async {
            semaphore.wait()
            
            self.searchedArticle = self.titles.filter({$0.contains(searchText)})
            self.isSearching = true
            
            semaphore.signal()
        }
        
        ///Reload tableView
        mainQueue.async {
            semaphore.wait()
            
            self.tableView.reloadData()
            
            semaphore.signal()
        }
        
        /// Show the cancel button
        searchBar.showsCancelButton = true
        
        ///Catch and Resign First Responder
        if searchText.isEmpty {
            mainQueue.asyncAfter(deadline: .now() + 0.1) {
                semaphore.wait()
                
                searchBar.resignFirstResponder()
                self.tableView.reloadData()
                
                semaphore.signal()
            }
        }
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let semaphore = DispatchSemaphore(value: 1)
        let mainQueue = DispatchQueue.main
    
        mainQueue.async {
            semaphore.wait()
            
            searchBar.text = ""
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
            
            semaphore.signal()
        }
        
        ///Reload tableView
        mainQueue.async {
            semaphore.wait()
            
            self.tableView.reloadData()
            
            semaphore.signal()
        }
        
        DispatchQueue.global().async {
            semaphore.wait()
            
            self.isSearching = false
            
            semaphore.signal()
        }
    }
}
