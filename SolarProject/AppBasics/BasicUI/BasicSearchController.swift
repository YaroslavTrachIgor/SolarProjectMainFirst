//
//  BasicSearchController.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 08.01.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import UIKit

protocol BasicSearchControllerProtocol {
    func setupTint()
    func setupSearchBar()
}

class BasicSearchController: UISearchController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
    
    func setupSearchController() {
        setupSearchBar()
        setupTint()
    }
}

extension BasicSearchController: BasicSearchControllerProtocol {
    func setupTint() {
        view.tintColor = .biologyGreenColor
    }
    
    func setupSearchBar() {
        searchBar.barStyle       = .default
        searchBar.searchBarStyle = .minimal
        
        searchBar.clipsToBounds  = true
    }
}

func setupSearchBarFont() {
    let searchTextAppearance      = UITextField.self.appearance(whenContainedInInstancesOf: [UISearchBar.self])
    searchTextAppearance.font = UIFont(name: BasicFonts.mediumFont, size: 14)
    searchTextAppearance.textColor = .white
}
