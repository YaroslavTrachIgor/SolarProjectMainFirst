//
//  NewsTableViewController.swift
//  SolarProject
//
//  Created by Yaroslav on 20.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit
import Firebase
import FirebaseRemoteConfig
import SafariServices

//MARK: - NewsTableViewControllerProtocol protocol
protocol NewsTableViewControllerProtocol {
    func setupContent()
}


//MARK: - SectionType enum extension
extension NewsTableViewController {
    enum SectionType {
        case site
        case news
    }
}



//MARK: - NewsTableViewController main class
final class NewsTableViewController: UITableViewController {

    /// Sections
    var sections: [SectionType] = [.site, .news]
    
    /// RemoteConfig
    var remoteConfig: RemoteConfig!
    
    /// Model
    var model: NewsModel!
    
    
    //MARK: Private
    //BasicSearchController
    private lazy var searchController = BasicSearchController()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    //BasicRefreshControl
    private lazy var menuRefreshControl: UIRefreshControl = {
        let refreshControl = BasicRefreshControl()
        return refreshControl
    }()
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRemoteConfig()
        configureRemoteConfig()
        setupModel()

        ///Setup UI
        setupTableView()
        setupNavBar()
        setupSearchController()
        setupStatusBar()
        setupRefreshControl()
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        switch sectionType {
            case .news:
                return "News"
            case .site:
                return "Website"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let sectionType = sections[section]
        switch sectionType {
            case .news:
                return 4
            case .site:
                return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .news:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            let mainQueue = DispatchQueue.main
            let semaphore = DispatchSemaphore(value: 1)
            
            mainQueue.async {
                semaphore.wait()
                
                self.setupContent()
                
                semaphore.signal()
            }
            
            mainQueue.async {
                semaphore.wait()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    UIView.animate(withDuration: 0.4) {
                        self.setupContent(cell: cell, row: indexPath.row)
                    }
                })
                
                semaphore.signal()
            }
            
            mainQueue.async {
                semaphore.wait()
                
                ///Setup Views
                self.setupContentBack(contentBack: cell.contentBack)
                self.setupContentTextView(contentTextView: cell.contentTextView)
                self.setupTitleLabel(titleLabel: cell.titleLabel)
                self.setupSubtitleLabel(subtitleLabel: cell.subtitleLabel)
                self.setupSelectionBack(cell: cell)
                
                semaphore.signal()
            }
            
            ///Set tableView rowHeight
            tableView.rowHeight = 420
            
            return cell
        case .site:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SiteCell", for: indexPath)
            
            ///Setup label
            setupURLTextLabel(label: cell.textLabel)
            setupSelectionBack(cell: cell)
            
            ///Set tableView rowHeight
            tableView.rowHeight = 40
            
            cell.accessoryType = .detailButton
            cell.tintColor = BasicProperties.color
            cell.backgroundColor = .white
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = sections[indexPath.section]
        switch sectionType {
            case .site:
                showSafariSite(stringURL: "https://spacenews.com")
            case .news:
                break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailNewsSegue" {
            let destVC = segue.destination as! NewsViewController
            let cell = sender as! NewsCell
            
            destVC.mainTitle = cell.titleLabel.text!
            destVC.date = cell.dateLabel.text!
            destVC.content = cell.contentTextView.text!
            destVC.image = cell.newsImageView.image!
        }
    }
}



//MARK: - NewsTableViewController main methods
extension NewsTableViewController: NewsTableViewControllerProtocol {
    
    //MARK: NewsTableViewControllerProtocol
    func setupContent() {
        remoteConfig.fetchAndActivate { (status, error) in
            if error != nil {
                FastAlert.showBasic(title: nil, message: error!.localizedDescription, vc: self)
            } else {
                if status != .error {
                    if let title1    = self.remoteConfig["news_title_first"].stringValue,
                       let content1  = self.remoteConfig["news_content_first"].stringValue,
                       let date1     = self.remoteConfig["news_date_first"].stringValue,
                       let title2    = self.remoteConfig["news_title_second"].stringValue,
                       let content2  = self.remoteConfig["news_content_second"].stringValue,
                       let date2     = self.remoteConfig["news_date_second"].stringValue,
                       let title3    = self.remoteConfig["news_title_third"].stringValue,
                       let content3  = self.remoteConfig["news_content_third"].stringValue,
                       let date3     = self.remoteConfig["news_date_third"].stringValue,
                       let title4    = self.remoteConfig["news_title_forth"].stringValue,
                       let content4  = self.remoteConfig["news_content_forth"].stringValue,
                       let date4     = self.remoteConfig["news_date_forth"].stringValue,
                       let image1    = self.remoteConfig["news_image_first"].stringValue,
                       let image2    = self.remoteConfig["news_image_second"].stringValue,
                       let image3    = self.remoteConfig["news_image_third"].stringValue,
                       let image4    = self.remoteConfig["news_image_forth"].stringValue {
                        
                        ///Add titles
                        self.model.newsTitles.append(title1)
                        self.model.newsTitles.append(title2)
                        self.model.newsTitles.append(title3)
                        self.model.newsTitles.append(title4)
                        
                        ///Add content
                        self.model.newsContents.append(content1)
                        self.model.newsContents.append(content2)
                        self.model.newsContents.append(content3)
                        self.model.newsContents.append(content4)
                        
                        ///Add dates
                        self.model.newsDates.append(date1)
                        self.model.newsDates.append(date2)
                        self.model.newsDates.append(date3)
                        self.model.newsDates.append(date4)
                        
                        
                        ///Add images urls
                        self.model.newsImagesStringURLs.append(image1)
                        self.model.newsImagesStringURLs.append(image2)
                        self.model.newsImagesStringURLs.append(image3)
                        self.model.newsImagesStringURLs.append(image4)
                    }
                } else {
                    FastAlert.showBasic(title: "Error", message: error!.localizedDescription, vc: self)
                }
            }
        }
    }
    
    //MARK: Private
    private func showSafariSite(stringURL: String) {
        if let url = URL(string: stringURL) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            vc.preferredControlTintColor = BasicProperties.color
            present(vc, animated: true)
        }
    }
    
    private func setupContent(cell: NewsCell, row: Int) {
        UIView.transition(with: view, duration: 0.4, options: .curveEaseIn, animations: {
            cell.titleLabel.text         = self.model.newsTitles[row]
            cell.subtitleLabel.text      = cell.titleLabel.text!
            cell.contentTextView.text    = self.model.newsContents[row]
            cell.dateLabel.text          = self.model.newsDates[row]
            cell.newsImageView.downloaded(from: self.model.newsImagesStringURLs[row])
        }, completion: nil)
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = menuRefreshControl
        menuRefreshControl.addTarget(self, action: #selector(setupRefreshControlAction), for: .valueChanged)
    }
    
    private func setupTitleLabel(titleLabel: UILabel) {
        titleLabel.textColor = BasicProperties.color
        titleLabel.labelShadow()
        titleLabel.layer.shadowColor = BasicProperties.color.cgColor
        titleLabel.numberOfLines = 1
    }
    
    private func setupSubtitleLabel(subtitleLabel: UILabel) {
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.alpha = 1
        subtitleLabel.isHidden = false
        subtitleLabel.numberOfLines = 1
    }
    
    private func setupContentBack(contentBack: UIView) {
        contentBack.layer.cornerRadius = BasicProperties.cornerRadius + 12
        contentBack.viewShadows()
    }
    
    private func setupContentTextView(contentTextView: UITextView) {
        contentTextView.layer.cornerRadius = BasicProperties.cornerRadius + 12
        contentTextView.isEditable = false
        contentTextView.isSelectable = false
        contentTextView.isScrollEnabled = false
    }
    
    private func setupURLTextLabel(label: UILabel?) {
        label?.text = "https://spacenews.com"
        label?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label?.textColor = BasicProperties.color
    }
    
    private func setupSelectionBack(cell: UITableViewCell) {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SiteCell")
        tableView.separatorColor = #colorLiteral(red: 0.9605281565, green: 0.9605281565, blue: 0.9605281565, alpha: 1)
    }
    
    private func setupModel() {
        model = NewsModel()
    }
    
    private func setRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search News"
        searchController.searchBar.tintColor = BasicProperties.color
        searchController.searchBar.textField?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        navigationItem.searchController = searchController
    }
    
    private func setupStatusBar() {
        if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_7 || DeviceType.IS_IPHONE_7P || DeviceType.IS_IPAD {
            setupBasicStatusBarView(with: 20)
        } else {
            setupBasicStatusBarView(with: 50)
        }
    }
    
    private func setupNavBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.setupBasicShadow(color: #colorLiteral(red: 0.9072133845, green: 0.9072133845, blue: 0.9072133845, alpha: 1))
        navBar.shadowImage = UIImage()
        navBar.backgroundColor = .systemGroupedBackground
        navBar.barTintColor = .systemGroupedBackground
    }
    
    private func configureRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    private func setupBasicStatusBarView(with size: CGFloat) {
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: size))
        statusBarView.backgroundColor = .systemGroupedBackground
        navigationController?.view.addSubview(statusBarView)
    }
    
    
    //MARK: @objc
    @objc func setupRefreshControlAction() {
        tableView.reloadData()
    }
}
