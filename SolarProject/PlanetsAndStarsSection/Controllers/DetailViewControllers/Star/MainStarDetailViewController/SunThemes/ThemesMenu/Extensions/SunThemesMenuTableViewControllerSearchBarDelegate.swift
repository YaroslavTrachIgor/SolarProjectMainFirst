//
//  SunThemesMenuTableViewControllerSearchBarDelegate.swift
//  SolarProject
//
//  Created by Yaroslav on 30.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UISearchBarDelegate
extension SunThemesMenuTableViewController: UISearchBarDelegate {
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mainQueue = DispatchQueue.main
        let semaphore = DispatchSemaphore(value: 1)
        
        mainQueue.async { [self] in
            semaphore.wait()
            
            searchedArticle = PlanetsMenuTableViewControllerModel.StarsContent.themesContentTitles.filter({$0.contains(searchText)})
            isSearching = true
            
            semaphore.signal()
        }
        
        mainQueue.async {
            semaphore.wait()
            
            ///Reload tableView
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            semaphore.signal()
        }
        
        mainQueue.async {
            semaphore.wait()
            
            /// Show the cancel button
            searchBar.showsCancelButton = true
            
            semaphore.signal()
        }
        
        mainQueue.async {
            semaphore.wait()
            
            ///Catch and Resign First Responder
            if searchText.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    searchBar.resignFirstResponder()
                    self.tableView.reloadData()
                }
            }
            
            semaphore.signal()
        }
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let mainQueue = DispatchQueue.main
        let semaphore = DispatchSemaphore(value: 1)
        
        mainQueue.async {
            semaphore.wait()
            
            searchBar.text = ""
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
            
            semaphore.signal()
        }
        
        mainQueue.async {
            semaphore.wait()
            
            ///Reload tableView
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            semaphore.signal()
        }
        
        mainQueue.async {
            semaphore.wait()
            
            self.isSearching = false
            
            semaphore.signal()
        }
    }
}

