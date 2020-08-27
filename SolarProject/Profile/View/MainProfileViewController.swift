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

//MARK: - MainProfileViewController extension
extension MainProfileViewController {
    
    //MARK: SectionType enum
    enum SectionType {
        case userAccaunt
        case applicationInfo
        case permissions
        case settings
    }
    
    
    //MARK: Keys
    enum Keys {
        
        ///DefaultsKeys
        enum DefaultsKeys: String {
            case fullNameKay = "fullNameKay"
            case emailKey    = "emailKey"
            case phoneKey    = "phoneKey"
        }
        
        ///DefaultsKeys
        enum SeguesKeys: String {
            case analyticsSegue       = "UserAnalyticsSegue"
            case profileAccountSegue  = "UserProfileAccountSegue"
            case notificationSegue    = "NotificationsVCSegue"
            case appearanceSegue      = "AppearanceSegue"
            case applicationInfoSegue = "ApplicationInfoSegue"
            case supportSegue         = "SupportSecondSegue"
        }
    }
    
    
    //MARK: Permissions Content
    private enum PermissionsContent: String {
        case titleText   = "Need Permissions"
        case headerText  = "This Permissions need for work app, see decription to each permission."
        case footerText  = "Permissions are necessary for the correct work of the application and the performance of all functions."
    }
}



//MARK: - MainProfileViewController main class
final class MainProfileViewController: BasicViewController {
    
    //MARK: Presenter
    var presenter: MainProfileViewControllerPresenterProtocol {
        return MainProfileViewControllerPresenter(sections: sections)
    }
    
    ///GADInterstitial
    private var interstitial: GADInterstitial!
    
    ///Sections
    var sections: [SectionType] = [.userAccaunt, .applicationInfo, .settings, .permissions]

    
    //MARK: UserDefaults
    let defaults = UserDefaults.standard
    
    
    //MARK: @IBOutlets
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userIconImageView: UIImageView!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        ///Setup UI
        setupBasicViewControllerUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        setupContent(segue)
    }
    
    
    //MARK: BasicViewControllerProtocol method
    internal func setupBasicViewControllerUI() {
        
        ///Setup UI
        setupNavController()
        setupTableView()
        setupImageView()
        setupInterstitial()
        setupFullNameLabel()
        setupEmailLabel()
    }
}



//MARK: - MainProfileViewControllerProtocol extension
extension MainProfileViewController {
    
    //MARK: UI setup
    private func setupContent(_ segue: UIStoryboardSegue) {
        if segue.identifier == Keys.SeguesKeys.profileAccountSegue.rawValue, case let destVC = segue.destination as! AccountVC {
            /* Setup labels content with AccountVC.
            Here is using completion Callback. */
            destVC.completion = { [unowned self] fullName, email in
                self.setupBasicSeguesContent(email: email, fullName: fullName)
            }

            ///Setup  userIconImageView  image  with  presenter
            userIconImageView.image = presenter.setupSegueImage(segue: segue)

            ///Save Labels
            defaults.set(self.fullNameLabel.text!, forKey: MainProfileViewController.Keys.DefaultsKeys.fullNameKay.rawValue)
            defaults.set(self.emailLabel.text!, forKey: MainProfileViewController.Keys.DefaultsKeys.emailKey.rawValue)
        }
    }
    
    private func setupBasicSeguesContent(email: String, fullName: String) {
        let defaultName = "Profile"
        let defaultEmail = "Profile Account"
        
        ///Set email
        if email == "" || email == " " { emailLabel.text = defaultEmail }
        else { emailLabel.text = email }
        
        ///Set fullName
        if fullName == "" || fullName == " " { fullNameLabel.text = defaultName }
        else { fullNameLabel.text = fullName }
    }
    
    private func setupImageView() {
        userIconImageView.setupProfileImageView()
        userIconImageView.image = presenter.setupProfileImage()
    }
    
    private func setupFullNameLabel() {
        fullNameLabel.text = presenter.setupFullName()
        fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.textColor = .black
    }
    
    private func setupEmailLabel() {
        emailLabel.setupBasicProfileDetailLabel(text: presenter.setupEmail())
    }
    
    private func setupTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.backgroundColor = .systemGroupedBackground
        profileTableView.separatorColor = UIColor.TableViewColors.tableViewSeparatorColor
        profileTableView.separatorStyle = .singleLine
    }
    
    private func setupNavController() {
        title = "Settings"
    }
    
    private func setupInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-8702634561077907/1153983852")
        let request = GADRequest()
        interstitial.load(request)
    }

    private func setupPermissionsController() {
        let controller = SPPermissions.list([.photoLibrary, .camera, .notification])
        controller.titleText = PermissionsContent.titleText.rawValue
        controller.headerText = PermissionsContent.headerText.rawValue
        controller.footerText = PermissionsContent.footerText.rawValue
        controller.dataSource = self
        controller.delegate = self
        controller.present(on: self)
    }
    
    
    //MARK: Internal
    internal func setupSegues(indexPath: IndexPath) {
        let row = indexPath.row
        
        ///Setup Analytics Segue
        func setupAnalyticsSegue() {
            self.performSegue(withIdentifier: Keys.SeguesKeys.analyticsSegue.rawValue, sender: self)
        }
        
        //MARK: Setup all Segues
        let section = sections[indexPath.section]
        switch section {
        case .userAccaunt:
            if row == 0 {
                self.performSegue(withIdentifier: Keys.SeguesKeys.profileAccountSegue.rawValue, sender: self)
            } else {
                if interstitial.isReady {
                    interstitial.present(fromRootViewController: self)
                    setupAnalyticsSegue()
                } else {
                    setupAnalyticsSegue()
                }
            }
        case .settings:
            if indexPath.row == 0 {
                performSegue(withIdentifier: Keys.SeguesKeys.notificationSegue.rawValue, sender: self)
            } else {
                performSegue(withIdentifier: Keys.SeguesKeys.appearanceSegue.rawValue, sender: self)
            }
        case .applicationInfo:
            performSegue(withIdentifier: Keys.SeguesKeys.applicationInfoSegue.rawValue, sender: self)
        case .permissions:
            
            ///Show Permissions VC
            if indexPath.row == 0 {
                setupPermissionsController()
            } else {
                performSegue(withIdentifier: Keys.SeguesKeys.supportSegue.rawValue, sender: self)
            }
        }
    }
}
