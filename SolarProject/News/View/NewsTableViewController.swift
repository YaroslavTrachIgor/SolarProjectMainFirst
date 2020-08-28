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
    func setupContent(completion: @escaping () -> Void)
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

    ///Presenter
    fileprivate var presenter: NewsTVCPresenterProtocol {
        return NewsTVCPresenter(sections: self.sections)
    }
    
    ///Sections
    var sections: [SectionType] = [.news, .site]
    
    ///RemoteConfig
    var remoteConfig: RemoteConfig!
    

    //MARK: News Main Content Array
    var news = [News]()
    
    
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
        setupContent(completion: {
            self.tableView.reloadData()
        })

        ///Setup UI
        setupTableView()
        setupSearchController()
        setupRefreshControl()
        setupNavBar()
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.setupTitleForHeader(section: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return presenter.setupTitleForFooter(section: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let sectionType = sections[section]
        switch sectionType {
        case .news:
            return news.count
        case .site:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .news:
            return setupNewsCell(tableView: tableView, indexPath: indexPath)
        case .site:
            return setupSiteCell(tableView: tableView, indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .site:
            showSafariSite()
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
    internal func setupContent(completion: @escaping () -> Void) {
        remoteConfig.fetchAndActivate { (status, error) in
            if error != nil {
                AlertManeger.presentAlert(title: nil, message: error!.localizedDescription, vc: self)
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
                        
                        ///Setup News array
                        self.news = [
                            News(title: title1, content: content1, date: date1, imageURL: image1),
                            News(title: title2, content: content2, date: date2, imageURL: image2),
                            News(title: title3, content: content3, date: date3, imageURL: image3),
                            News(title: title4, content: content4, date: date4, imageURL: image4)
                        ]
                        
                        
                        ///Completion
                        completion()
                    }
                } else {
                    AlertManeger.presentAlert(title: "Error", message: error!.localizedDescription, vc: self)
                }
            }
        }
    }
    
    //MARK: Private
    private func setupNewsCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let mainQueue = DispatchQueue.main
        let semaphore = DispatchSemaphore(value: 1)
        
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
            self.setupImageView(imageView: cell.newsImageView)
            
            semaphore.signal()
        }
        
        ///Set tableView rowHeight
        tableView.rowHeight = 420
        
        return cell
    }
    
    private func setupSiteCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
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
    
    private func showSafariSite() {
        showSafariVC(with: presenter.setupStringSiteLink())
    }
    
    private func setupContent(cell: NewsCell, row: Int) {
        UIView.transition(with: view, duration: 0.4, options: .curveEaseIn, animations: {
            let news = self.news[row]
            cell.titleLabel.text         = news.title
            cell.subtitleLabel.text      = cell.titleLabel.text!.uppercased()
            cell.contentTextView.text    = news.content
            cell.dateLabel.text          = news.date
            cell.newsImageView.downloaded(from: news.imageURL)
        }, completion: nil)
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = menuRefreshControl
        menuRefreshControl.addTarget(self, action: #selector(setupRefreshControlAction), for: .valueChanged)
    }
    
    private func setupImageView(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFit
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
        subtitleLabel.font = UIFont.systemFont(ofSize: 11.5, weight: .semibold)
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
        tableView.separatorColor = UIColor.TableViewColors.tableViewSeparatorColor
        tableView.separatorStyle = .singleLine
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
    
    private func setupNavBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.backgroundColor = .systemGroupedBackground
    }
    
    private func configureRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    
    //MARK: @objc
    @objc func setupRefreshControlAction() {
        tableView.reloadData()
    }
}
