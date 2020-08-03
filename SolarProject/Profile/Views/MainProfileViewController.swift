//
//  MainProfileViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 02.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SPPermissions

//MARK: - MainProfileViewControllerTableViewMethodsSetupProtocol protocol
protocol MainProfileViewControllerTableViewMethodsSetupProtocol {
    func setupNumberOfRowsInSection() -> Int
    func setupNumberOfSections(section: Int) -> Int
    func setupCellTitles(cell: UITableViewCell, indexPath: IndexPath)
    func setupSegues(indexPath: IndexPath)
    func setupSectionHeaders(section: Int) -> String?
}



//MARK: - MainProfileViewController main class
final class MainProfileViewController: BasicViewController {

    //MARK: Presenter
    private var presenter: MainProfileViewControllerPresenter {
        return MainProfileViewControllerPresenter()
    }
    
    ///GADInterstitial
    private var interstitial: GADInterstitial!
    

    //MARK: Keys
    enum Keys: String {
        case fullNameKay = "fullNameKay"
        case emailKey    = "emailKey"
        case phoneKey    = "phoneKey"
    }
    
    //MARK: UserDefaults
    let defaults = UserDefaults.standard
    
    
    //MARK: @IBOutlets
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var mainTableViewBack: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var userIconBackgroundImageView: UIImageView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    @IBOutlet weak var blackBackgroundView: UIView!
    @IBOutlet weak var editProfileButton: UIButton!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        ///Setup UI
        setupBasicViewControllerUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserProfileAccountSegue" {
            userIconImageView.image = presenter.setupSegueImage(segue: segue)
            fullNameLabel.text = presenter.setupSegueFullName(segue: segue)
            emailLabel.text = presenter.setupSegueEmail(segue: segue)
            phoneLabel.text = presenter.setupSeguePhone(segue: segue)
                
            ///Save fullNameLabel text
            defaults.set(self.fullNameLabel.text!, forKey: MainProfileViewController.Keys.fullNameKay.rawValue)
            defaults.set(self.emailLabel.text!, forKey: MainProfileViewController.Keys.emailKey.rawValue)
            defaults.set(self.phoneLabel.text!, forKey: MainProfileViewController.Keys.phoneKey.rawValue)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupBlurEffectView()
    }
    
    
    //MARK: BasicViewControllerProtocol method
    internal func setupBasicViewControllerUI() {
        
        ///Setup UI
        setupNavController()
        setupTableView()
        setupTableViewBack()
        setupImageView()
        setupBackImageView()
        setupBlurEffectView()
        setupBlurEffectView()
        setupEditProfileButton()
        setupInterstitial()
        setupFullNameLabel()
        setupEmailLabel()
        setupPhoneLabel()
    }
}



//MARK: - MainProfileViewControllerProtocol extension
extension MainProfileViewController: MainProfileViewControllerTableViewMethodsSetupProtocol {
    
    //MARK: UI setup
    private func setupEditProfileButton() {
        editProfileButton.layer.cornerRadius = BasicProperties.cornerRadius - 2
        editProfileButton.viewShadows()
        editProfileButton.layer.shadowColor = BasicProperties.color.cgColor
        editProfileButton.layer.shadowRadius = 3
        editProfileButton.backgroundColor = BasicProperties.color
        editProfileButton.setTitleColor(.white, for: .normal)
        editProfileButton.titleLabel?.labelShadow()
        editProfileButton.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        editProfileButton.tintColor = .white
        editProfileButton.setImage(UIImage(systemName: "pencil"), for: .normal)
    }
    
    private func setupBlackBackgroundView() {
        blackBackgroundView.viewShadows()
        blackBackgroundView.backgroundColor = .black
    }
    
    private func setupBlurEffectView() {
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = BasicProperties.cornerRadius + 14
        blurEffectView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        blurEffectView.viewShadows()
    }
    
    private func setupImageView() {
        userIconImageView.setupProfileImageView()
        userIconImageView.image = presenter.setupProfileImage()
    }
    
    private func setupBackImageView() {
        if let image = userIconImageView.image {
            userIconBackgroundImageView.image = image
        }
        userIconBackgroundImageView.layer.cornerRadius = BasicProperties.cornerRadius + 14
        userIconBackgroundImageView.tintColor = BasicProperties.color
    }
    
    private func setupFullNameLabel() {
        fullNameLabel.text = presenter.setupFullName()
        fullNameLabel.labelShadow()
    }
    
    private func setupEmailLabel() {
        emailLabel.text = presenter.setupEmail()
        emailLabel.labelShadow()
    }
    
    private func setupPhoneLabel() {
        phoneLabel.text = presenter.setupPhone()
        phoneLabel.labelShadow()
    }
    
    private func setupTableView() {
        
        ///Setup profileTableView delegate and dataSource
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        profileTableView.layer.cornerRadius = BasicProperties.cornerRadius + 14
        profileTableView.backgroundColor = .white
        profileTableView.separatorColor = #colorLiteral(red: 0.961242147, green: 0.961242147, blue: 0.961242147, alpha: 1)
    }
    
    private func setupTableViewBack() {
        mainTableViewBack.addNeomorphicOneSideShadowColor()
        mainTableViewBack.layer.cornerRadius = BasicProperties.cornerRadius + 14
        mainTableViewBack.backgroundColor = .white
    }
    
    private func setupNavController() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.setupBasicShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        navBar.layer.shadowRadius = 4
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.backgroundColor = .black
        
        ///Setup StatusBar
        if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_7 || DeviceType.IS_IPHONE_7P || DeviceType.IS_IPAD {
            setupStatusBarView(with: 20)
        } else {
            setupStatusBarView(with: 50)
        }
        
        ///Set title
        title = "Profile"
    }
    
    private func setupInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-8702634561077907/1153983852")
        let request = GADRequest()
        interstitial.load(request)
    }

    private func setupPermissionsController() {
        let controller = SPPermissions.list([.photoLibrary, .camera, .notification])
        controller.titleText = "Need Permissions"
        controller.headerText = "This Permissions need for work app, see decription to each permission."
        controller.footerText = "Permissions are necessary for the correct work of the application and the performance of all functions."
        controller.dataSource = self
        controller.delegate = self
        controller.present(on: self)
    }
    
    
    //MARK: For TableView
    internal func setupNumberOfRowsInSection() -> Int {
        return presenter.setupNumberOfRowsInSection()
    }
    
    internal func setupNumberOfSections(section: Int) -> Int {
        return presenter.setupNumberOfSections(section: section)
    }
    
    internal func setupCellTitles(cell: UITableViewCell, indexPath: IndexPath) {
        cell.textLabel?.text = presenter.setupLabelsText(section: indexPath.section, row: indexPath.row)
        cell.imageView?.image = UIImage(systemName: presenter.setupImagesNames(section: indexPath.section, row: indexPath.row))
        cell.imageView?.tintColor = presenter.setupImagesTintColors(section: indexPath.section, row: indexPath.row)
    }
    
    internal func setupSegues(indexPath: IndexPath) {
        let row = indexPath.row
        
        ///Setup Analytics Segue
        func setupAnalyticsSegue() {
            self.performSegue(withIdentifier: "UserAnalyticsSegue", sender: self)
        }
        
        //MARK: Setup all Segues
        if indexPath.section == 0 {
            if row == 0 {
                self.performSegue(withIdentifier: "UserProfileAccountSegue", sender: self)
            } else {
                if interstitial.isReady {
                    interstitial.present(fromRootViewController: self)
                    setupAnalyticsSegue()
                } else {
                    setupAnalyticsSegue()
                }
            }
        } else {
            if row == 0 {
                self.performSegue(withIdentifier: "ApplicationInfoSegue", sender: self)
            } else {
                
                ///Show Permissions
                setupPermissionsController()
            }
        }
    }
    
    internal func setupSectionHeaders(section: Int) -> String? {
        return presenter.setupSectionHeaders(section: section)
    }
    
    
    //MARK: Private
    private func setupStatusBarView(with size: CGFloat) {
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: size))
        statusBarView.backgroundColor = .black
        navigationController?.view.addSubview(statusBarView)
    }
}
