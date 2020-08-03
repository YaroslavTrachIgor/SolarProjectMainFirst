//
//  RemindersUISearchBarDelegateExtension.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UISearchBarDelegate extension
extension RemindersViewController: UISearchBarDelegate {
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedArticle = reminders.filter({$0.contains(searchText)})
        isSearching = true
        
        ///Reload tableView
        DispatchQueue.main.async {
            self.reloadTable()
        }
        
        /// Show the cancel button
        searchBar.showsCancelButton = true
        
        ///Catch and Resign First Responder
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
                self.reloadTable()
            }
        }
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        /// Stop doing the search stuff and clear the text in the search bar
        searchBar.text = ""
        
        /// Hide the cancel button
        searchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        
        ///Reload tableView
        DispatchQueue.main.async {
            self.reloadTable()
        }
        
        isSearching = false
    }
}

