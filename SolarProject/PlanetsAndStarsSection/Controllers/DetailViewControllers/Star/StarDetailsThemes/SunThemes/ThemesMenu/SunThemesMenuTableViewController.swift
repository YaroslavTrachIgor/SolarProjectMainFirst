//
//  SunThemesMenuTableViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 30.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit
import GoogleMobileAds

//MARK: - SunThemesMenuTableViewController main class
final class SunThemesMenuTableViewController: UITableViewController {
    
    //MARK: Public
    public var searchedArticle = [String]()
    public var isSearching: Bool = false
    
    
    //MARK: Private
    private var interstitial: GADInterstitial!
    private lazy var menuRefreshControl: UIRefreshControl = {
        let refreshControl = BasicRefreshControl()
        return refreshControl
    }()
    private lazy var searchController = BasicSearchController()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    
    //MARK: PlanetsMenuTableViewControllerPresenter
    fileprivate var presenter: SunThemesMenuTBVCPresenterProtocol {
        return SunThemesMenuTBVCPresenter()
    }
    
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearchController()
        setupRefreshControl()
        setupInterstitial()
        setupTitle()
    }

    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        ///Setup Header
        return "Sun Themes"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        ///Setup number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        ///Setup number of rows in section
        return setupNumberOfRowsInSection()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SunThemeTableViewCell", for: indexPath) as! SunThemesMenuTableViewCell

        ///Setup Content
        setupContent(cell: cell, indexPath: indexPath)
        setupSelectionBack(cell: cell)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func setupSegue() {
            performSegue(withIdentifier: "SunThemeSegue", sender: self)
        }
        
        ///Setup starThemeIndex
        presenter.setupStarThemeIndex(indexPath: indexPath)
        
        ///Setup Segue
        if interstitial.isReady && ((indexPath.row % 2) == 0) {
            interstitial.present(fromRootViewController: self)
        }
        setupSegue()
    }
}



//MARK: - SunThemesMenuTableViewControllerProtocol extension
extension SunThemesMenuTableViewController {
    
    //MARK: Private
    private func setupContent(cell: SunThemesMenuTableViewCell, indexPath: IndexPath) {
        if isSearching {

            ///Setup when searching
            setupFastContent(cell: cell, title: searchedArticle[indexPath.row], content: searchedArticle[indexPath.row] + " theme")
        } else {
            
            ///Setup basic content
            setupFastContent(cell: cell, title: presenter.setupContentTitle(indexPath: indexPath), content: presenter.setupPreviewContent(indexPath: indexPath))
        }
    }

    private func setupFastContent(cell: SunThemesMenuTableViewCell, title: String, content: String) {
        cell.titleLabel?.text = title
        cell.previewTextView?.text = content
    }
    
    private func setupInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-8702634561077907/8242136384")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        setupSearchBar(searchController.searchBar)
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = menuRefreshControl
    }
    
    private func setupNumberOfRowsInSection() -> Int {
        if isSearching {
            return searchedArticle.count
        } else {
            return presenter.setupNumberOfRowsInSection()
        }
    }
    
    private func setupTableView() {
        tableView.rowHeight = 105
        tableView.backgroundColor = .systemGroupedBackground
        tableView.alpha = 1
    }
    
    private func setupSelectionBack(cell: SunThemesMenuTableViewCell) {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
    }
    
    private func setupTitle() {
        title = "Themes"
    }
    
    private func setupSearchBar(_ searchBar: UISearchBar) {
        let searchField = searchBar.value(forKey: "searchField") as? UITextField
        if let field = searchField {
            field.setupBasicSearchBar()
        }
    }
}
