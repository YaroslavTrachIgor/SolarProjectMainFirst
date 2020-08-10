//
//  PlanetsMenuTableViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit
import GoogleMobileAds

//MARK: - PlanetsMenuTableViewController main class
final class PlanetsMenuTableViewController: UITableViewController {
    
    //MARK: @IBOutlets
    @IBOutlet var planetsTableView: UITableView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var moreCollectionView: UICollectionView!
    @IBOutlet weak var detailButtonsBackView: UIView!
    
    
    //MARK: Private Properties
    internal var searchedArticle = [String]()
    internal var isSearching: Bool = false
    
    ///Content
    let titles = PlanetsMenuTableViewControllerModel.planetsTitles
    
    ///PlanetsMenuTableViewControllerPresenter
    var presenter: PlanetsMenuTableViewControllerPresenterProtocol {
        return PlanetsMenuTableViewControllerPresenter()
    }
    
    ///Sections
    let sections: [MainPlanetsMenuSections] = [.stars, .planets]
    
    
    //UIRefreshControl
    private lazy var menuRefreshControl: UIRefreshControl = {
        let refreshControl = BasicRefreshControl()
        return refreshControl
    }()
    
    //BasicSearchController
    private lazy var searchController = BasicSearchController()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    ///GADInterstitial
    private var interstitial: GADInterstitial!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        setupSearchBar()
        setupStatusBar()
        setupNavBar()
        setupInterstitial()
        setupSeparator()
        setupNavBarShadow()
        setupMoreCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuGoPlanetImageVCSegue" {
            let destVC = segue.destination as! PlanetImageViewController
            let cell = sender as! ImagesCollectionViewCell
            
            destVC.image = cell.imageView.image!
        }
    }
    
    
    //MARK: Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.setupSectionHeaders(sections: sections, section: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        ///Number Of Rows in TableView
        return setupRows(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath) as! PlanetsMenuTableViewCell
        
        ///Setup Content
        if self.isSearching {
            setupContentWhileSearching(cell: cell, indexPath: indexPath)
        } else {
            setupPlanetsStandartContent(cell: cell, indexPath: indexPath)
        }
            
        ///Setup UI
        setupNotificationButton(cell.notificationButton)
        setupSelectionBack(cell: cell)
        setupContentTextView(cell.contentTextView!)
        setupContentTextViewBack(cell.contentTextViewBackground!)
        setupTitleLabel(cell: cell)
        setupReminderButton(cell.reminderButton)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ///Set index
        PlanetsMenuTableViewControllerModel.index = indexPath.row
        
        ///Setup segues
        if indexPath.section == 0 {
            performSegue(withIdentifier: "starDetailTableViewCellSegue", sender: self)
        } else {
            performSegue(withIdentifier: "planetsDetailTableViewCellSegue", sender: self)
        }
    }
}



//MARK: - @IBActions
extension PlanetsMenuTableViewController {
    @IBAction func showSupportVCWithAdd(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            if self.interstitial.isReady {
                self.interstitial.present(fromRootViewController: self)
            }
        }
    }
}



//MARK: - PlanetsMenuTableViewController Main Methods
extension PlanetsMenuTableViewController {
    
    //MARK: Internal
    internal func setupNemberOfRowsInSection() -> Int {
        return PlanetsMenuTableViewControllerModel.images.count
    }
    
    internal func setupImageCell(cell: ImagesCollectionViewCell, indexPath: IndexPath) {
        
        ///Setup cell UI
        guard let activityIndView    = cell.activityIndicator else { return }
        guard let imageViewBack      = cell.imageViewBack else { return }
        guard let imageView          = cell.imageView else { return }
        guard let imageViewBlurView  = cell.imageViewPreviewBlurView else { return }
        guard let detailLabel        = cell.planetDetailLabel else { return }
        guard let subDetailLabel     = cell.planetSecondDetailLabel else { return }
        
        cell.backgroundColor = .clear
        setupImageViewBlurView(imageViewBlurView: imageViewBlurView)
        setupImageView(imageView: imageView, indexPath: indexPath)
        setupPlanetDetailLabel(detailLabel: detailLabel, indexPath: indexPath)
        setupSubDetailLabel(subDetailLabel: subDetailLabel, indexPath: indexPath)
        
        ///Setup animation end
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            activityIndView.stopAnimating()
            imageViewBlurView.isHidden = true
        }
        
        setupImageViewBack(imageViewBack: imageViewBack)
    }
    
    internal func setupMoreCell(cell: MoreCollectionViewCell, indexPath: IndexPath) {
        let row = indexPath.row
        
        ///Setup cell UI
        guard let titleLabel            = cell.titleLabel else { return }
        guard let descriptionTextView   = cell.descriptionTextView else { return }
        guard let detailButton          = cell.detailButton else { return }
        guard let imageView             = cell.backImageView else { return }
        
        setupMoreCellBack(cell: cell, row: row)
        setupTitleLabel(label: titleLabel, row: row)
        setupDetailButton(button: detailButton, row: row)
        setupDescriptionTextView(textView: descriptionTextView, row: row)
        setupMoreCellImageView(imageView: imageView, row: row)
    }
    
    
    //MARK: Setup cell Content
    private func setupContentWhileSearching(cell: PlanetsMenuTableViewCell, indexPath: IndexPath) {
        cell.titleLabel.text = searchedArticle[indexPath.row]
        cell.contentTextView.text = cell.titleLabel.text!
    }
    
    private func setupPlanetsStandartContent(cell: PlanetsMenuTableViewCell, indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        cell.titleLabel.text = presenter.setupPlanetsTitlesContent(sections: sections, row: row, section: section)
        cell.contentTextView.text = presenter.setupTextViewsContent(sections: sections, row: row, section: section)
        cell.notificationButton.setTitle(presenter.setupNotificationButtonTitles(sections: sections, row: row, section: section), for: .normal)
    }
    
    private func setupHeaders(for section: Int) -> String? {
        return presenter.setupSectionHeaders(sections: sections, section: section)
    }
    
    
    //MARK: Setup (tableView cell!) UI
    private func setupInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-8702634561077907/1148268510")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    private func setupNotificationButton(_ button: UIButton) {
        button.setupBasicPlanetCellButton()
        button.setTitle("SET NOTIFICATION", for: .normal)
    }
    
    private func setupReminderButton(_ button: UIButton) {
        button.setupBasicPlanetCellButton()
        button.setTitle("PUT IN REMINDERS", for: .normal)
    }
    
    private func setupContentTextView(_ textView: UITextView) {
        let security = false
        textView.isScrollEnabled = security
        textView.isSelectable    = security
        textView.isEditable      = security
        textView.layer.cornerRadius = BasicProperties.cornerRadius + 13
    }
    
    private func setupContentTextViewBack(_ view: UIView) {
        view.layer.cornerRadius = BasicProperties.cornerRadius + 13
        view.viewShadows()
    }
    
    private func setupSelectionBack(cell: PlanetsMenuTableViewCell) {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
    }
    
    private func setupTitleLabel(cell: PlanetsMenuTableViewCell) {
        let label = cell.titleLabel!
        label.textColor = BasicProperties.color
        label.labelShadow()
        label.layer.shadowColor = BasicProperties.color.cgColor
    }
    
    private func setupRefreshControl() {
        planetsTableView.refreshControl = menuRefreshControl
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        setupSearchBar(searchController.searchBar)
    }
    
    private func setupStatusBar() {
        if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_7 || DeviceType.IS_IPHONE_7P || DeviceType.IS_IPAD {
            setupStatusBarView(with: 20)
        } else {
            setupStatusBarView(with: 50)
        }
    }
    
    private func setupNavBar() {
        let basicColor: UIColor = .systemGroupedBackground
        guard let navBar = navigationController?.navigationBar else { return }
        
        ///Set backColor
        navBar.backgroundColor = basicColor
        navBar.barTintColor = basicColor
        
        ///Set title
        title = "Menu"
    }
    
    private func setupNavBarShadow() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.setupBasicShadow(color: #colorLiteral(red: 0.9072133845, green: 0.9072133845, blue: 0.9072133845, alpha: 1))
        navBar.shadowImage = UIImage()
    }
    
    
    //MARK: Setup (moreCollectionView cell!) UI
    private func setupDetailButton(button: UIButton, row: Int) {
        button.isEnabled = false
        button.backgroundColor = .systemGroupedBackground
        button.layer.cornerRadius = button.frame.height / 2
        button.setTitleColor(BasicProperties.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.5, weight: .bold)
        button.viewShadows()
        button.setTitle(presenter.setupMoreItemsButtonsTitles(row: row), for: .normal)
    }
    
    private func setupTitleLabel(label: UILabel, row: Int) {
        label.alpha = 1
        label.isHidden = false
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.text = NSLocalizedString(" " + presenter.setupMoreItemsTitles(row: row), comment: "")
    }
    
    private func setupDescriptionTextView(textView: UITextView, row: Int) {
        textView.textColor = #colorLiteral(red: 0.9318338939, green: 0.9318338939, blue: 0.9318338939, alpha: 1)
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.isHidden = false
        textView.alpha = 1
        textView.layer.shadowRadius = 0
        textView.backgroundColor = .clear
        textView.text = presenter.setupMoreItemsDescriptions(row: row)
    }
    
    private func setupMoreCellBack(cell: MoreCollectionViewCell, row: Int) {
        
        ///Setup cell contentView
        let contentLayer = cell.contentView.layer
        contentLayer.cornerRadius = BasicProperties.cornerRadius
        contentLayer.borderWidth = 1.0
        contentLayer.borderColor = UIColor.clear.cgColor
        contentLayer.masksToBounds = true
        
        ///Setup cell
        let cellLayer = cell.layer
        cell.backgroundColor = presenter.setupMoreItemsBackColors(row: row)
        cellLayer.cornerRadius = BasicProperties.cornerRadius
        cellLayer.shadowColor = cell.backgroundColor!.cgColor
        cellLayer.shadowOffset = CGSize.zero
        cellLayer.shadowRadius = 14
        cellLayer.shadowOpacity = 0.5
        cellLayer.masksToBounds = false
        cellLayer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: contentLayer.cornerRadius).cgPath
    }
    
    private func setupMoreCellImageView(imageView: UIImageView, row: Int) {
        imageView.contentMode = .scaleAspectFill
        imageView.image = presenter.setupMoreCellBackImages(row: row)
    }
    
    
    //MARK: Setup (collectionView cell!) UI
    private func setupImageViewBlurView(imageViewBlurView: UIVisualEffectView) {
        imageViewBlurView.isHidden = false
        imageViewBlurView.layer.cornerRadius = BasicProperties.cornerRadius
        imageViewBlurView.layer.masksToBounds = true
    }
    
    private func setupImageView(imageView: UIImageView, indexPath: IndexPath) {
        imageView.downloaded(from: presenter.setupCollectionViewCellImageDownloadsContent(indexPath: indexPath))
        imageView.contentMode = .scaleAspectFill
    }
    
    private func setupPlanetDetailLabel(detailLabel: UILabel, indexPath: IndexPath) {
        detailLabel.setupCollectionViewDetailLabelShadow()
        detailLabel.text = presenter.setupImageCellPlanetDetailLabelContent(row: indexPath.row)
        detailLabel.labelShadow()
        detailLabel.layer.shadowColor = UIColor.white.cgColor
        detailLabel.textColor = .white
        detailLabel.clipsToBounds = false
        detailLabel.layer.masksToBounds = false
        detailLabel.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
    }
    
    private func setupSubDetailLabel(subDetailLabel: UILabel, indexPath: IndexPath) {
        subDetailLabel.textColor = .systemGroupedBackground
        subDetailLabel.text = presenter.setupImageCellPlanetSubDetailLabelContent(row: indexPath.row)
        subDetailLabel.setupCollectionViewDetailLabelShadow()
        subDetailLabel.font = UIFont.systemFont(ofSize: 8, weight: .regular)
    }
    
    private func setupImageViewBack(imageViewBack: UIView) {
        imageViewBack.layer.cornerRadius = BasicProperties.cornerRadius
        imageViewBack.layer.masksToBounds = true
    }

    private func setupSearchBar(_ searchBar: UISearchBar) {
        let searchField = searchBar.value(forKey: "searchField") as? UITextField

        if let field = searchField {
            field.setupBasicSearchBar()
        }
    }
    
    private func setupSeparator() {
        tableView.separatorColor = #colorLiteral(red: 0.965946613, green: 0.965946613, blue: 0.965946613, alpha: 1)
        tableView.separatorStyle = .singleLine
    }
    
    private func setupCollectionView() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        moreCollectionView.tag = 0
    }
    
    private func setupMoreCollectionView() {
        moreCollectionView.delegate = self
        moreCollectionView.dataSource = self
        moreCollectionView.tag = 1
        moreCollectionView.backgroundColor = .systemGroupedBackground
        
        ///Setup collectionViewLayout
        let layout = moreCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 200, height: 120)
    }
    
    private func setupRows(section: Int) -> Int {
        if isSearching {
            return searchedArticle.count
        } else {
            return presenter.setupSectionRows(sections: sections, section: section)
        }
    }
    
    private func setupStatusBarView(with size: CGFloat) {
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: size))
        statusBarView.backgroundColor = .systemGroupedBackground
        navigationController?.view.addSubview(statusBarView)
    }
}
