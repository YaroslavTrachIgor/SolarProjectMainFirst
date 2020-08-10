//
//  BasicSearchController.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 08.01.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import UIKit

//MARK: - BasicSearchControllerProtocol protocol
protocol BasicSearchControllerProtocol {
    func setupTint()
    func setupSearchBar()
}



//MARK: - BasicSearchController main class
final class BasicSearchController: UISearchController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
    
    func setupSearchController() {
        setupSearchBar()
        setupTint()
    }
}



//MARK: - BasicSearchControllerProtocol extension
extension BasicSearchController: BasicSearchControllerProtocol {
    func setupTint() {
        view.tintColor = .orange
    }
    
    func setupSearchBar() {
        
        ///Setup style
        searchBar.barStyle       = .default
        searchBar.searchBarStyle = .minimal
        
        searchBar.clipsToBounds  = true
    }
}



//MARK: - Setup SearchBar UIFont
func setupSearchBarFont() {
    let searchTextAppearance = UITextField.self.appearance(whenContainedInInstancesOf: [UISearchBar.self])
    searchTextAppearance.font = UIFont(name: BasicProperties.BasicFonts.mediumFont, size: 14)
    searchTextAppearance.textColor = .white
}
