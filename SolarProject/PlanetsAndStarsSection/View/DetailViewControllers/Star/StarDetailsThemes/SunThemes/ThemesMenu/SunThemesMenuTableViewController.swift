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
        
        ///Setup View
        view.backgroundColor = UIColor.TableViewColors.tableViewBackgroundColor
    }

    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        ///Setup Header
        return presenter.setupSectionHeader()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        ///Setup number of sections
        return presenter.setupNumberOfSections()
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
        setupSubtitleLabel(label: cell.subtitleLabel)
        setupTitleLabel(label: cell.titleLabel)
        
        ///Setup cell
        let backColor: UIColor = .systemBackground
        cell.backgroundColor = backColor
        cell.contentView.backgroundColor = backColor

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
        cell.subtitleLabel?.text = title.uppercased()
        cell.previewTextView?.text = content
    }
    
    private func setupInterstitial() {
        let request = GADRequest()
        let adUnit = "ca-app-pub-8702634561077907/8242136384"
        interstitial = GADInterstitial(adUnitID: adUnit)
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
        tableView.rowHeight = 125
        tableView.backgroundColor = UIColor.TableViewColors.tableViewBackgroundColor
        tableView.separatorColor = UIColor.TableViewColors.tableViewSeparatorColor
        tableView.separatorStyle = .singleLine
        tableView.alpha = 1
    }
    
    private func setupSubtitleLabel(label: UILabel) {
        let font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .secondaryLabel
        label.backgroundColor = .clear
        label.alpha = 1
        label.font = font
    }
    
    private func setupTitleLabel(label: UILabel) {
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.backgroundColor = .clear
        label.alpha = 1
        label.font = font
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
