//
//  MainProfileViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 04.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - MainProfileViewControllerPresenterDefaultContentProtocol protocol
public protocol MainProfileViewControllerPresenterDefaultContentProtocol {
    func setupProfileImage() -> UIImage?
    func setupEmail() -> String
    func setupFullName() -> String
}



//MARK: - MainProfileViewControllerPresenterSegueContentProtocol protocol
public protocol MainProfileViewControllerPresenterSegueContentProtocol {
    func setupSegueImage(segue: UIStoryboardSegue) -> UIImage
}



//MARK: - MainProfileViewControllerPresenterTableViewMethodsSetupProtocol protocol
public protocol MainProfileViewControllerPresenterTableViewMethodsSetupProtocol {
    func setupSectionHeaders(section: Int) -> String?
    func setupNumberOfRowsInSection() -> Int
    func setupNumberOfSections(section: Int) -> Int
    func setupImagesTintColors(section: Int, row: Int) -> UIColor?
    func setupImagesNames(section: Int, row: Int) -> String?
    func setupLabelsText(section: Int, row: Int) -> String
    func setupSectionFooters(section: Int) -> String?
}



//MARK: - MainProfileViewControllerPresenterProtocol protocol
public protocol MainProfileViewControllerPresenterProtocol: MainProfileViewControllerPresenterSegueContentProtocol, MainProfileViewControllerPresenterDefaultContentProtocol, MainProfileViewControllerPresenterTableViewMethodsSetupProtocol {}



//MARK: - MainProfileViewControllerPresenter
final class MainProfileViewControllerPresenter {
    let sections: [MainProfileViewController.SectionType]
    
    init(sections: [MainProfileViewController.SectionType]) {
        self.sections = sections
    }
}



//MARK: - MainProfileViewControllerPresenterProtocol extension
extension MainProfileViewControllerPresenter: MainProfileViewControllerPresenterProtocol {
    
    //MARK: MainProfileViewControllerPresenterSegueContentProtocol functions
    internal func setupSegueImage(segue: UIStoryboardSegue) -> UIImage {
        let destVC = segue.destination as! AccountVC
        let data = destVC.defaults.object(forKey: AccountVC.Keys.userPhotoKey) as! NSData?
        if data != nil {
            return UIImage(data: (data!) as Data)!
        } else {
            return UIImage(systemName: "person.crop.circle")!
        }
    }
    
    
    //MARK: MainProfileViewControllerPresenterDefaultContentProtocol functions
    internal func setupFullName() -> String {
        let value = defaults.value(forKey: MainProfileViewController.Keys.DefaultsKeys.fullNameKay.rawValue) as? String ?? "Profile"
        if value == "" || value == " " { return "Profile" } else { return "\(value)" }
    }
    
    internal func setupProfileImage() -> UIImage? {
        let data = UserDefaults.standard.object(forKey: AccountVC.Keys.userPhotoKey) as! NSData?
        if data != nil { return UIImage(data: (data!) as Data) } else { return UIImage(systemName: "person.crop.circle") }
    }
    
    internal func setupEmail() -> String {
        let value = defaults.value(forKey: MainProfileViewController.Keys.DefaultsKeys.emailKey.rawValue) as? String ?? "Profile Account"
        if value == "" || value == " " { return "Profile Account" } else { return "\(value)" }
    }
    
    
    //MARK: MainProfileViewControllerPresenterTableViewMethodsSetupProtocol functions
    internal func setupSectionFooters(section: Int) -> String? {
        let section = sections[section]
        switch section {
        case .userAccaunt:
            return "In this section you can view personal information and analytics about yourself as well as fill out personal information about yourself."
        case .applicationInfo:
            return "In this section, you can read about the application and its main functions."
        case .settings:
            return nil
        case .permissions:
            return "Permissions are necessary for the correct work of the application and the performance of all functions."
        }
    }
    
    internal func setupSectionHeaders(section: Int) -> String? {
        let section = sections[section]
        switch section {
        case .userAccaunt:
            return "User Account"
        case .applicationInfo:
            return nil
        case .settings:
            return "Settings"
        case .permissions:
            return "Application Permissions"
        }
    }
    
    internal func setupNumberOfRowsInSection() -> Int {
        return sections.count
    }
    
    internal func setupNumberOfSections(section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .userAccaunt:
            return 2
        case .applicationInfo:
            return 1
        case .settings:
            return 2
        case .permissions:
            return 2
        }
    }
    
    internal func setupImagesTintColors(section: Int, row: Int) -> UIColor? {
        let section = sections[section]
        switch section {
        case .userAccaunt:
            if row == 0 {
                return #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            } else {
                return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            }
        case .applicationInfo:
            return BasicProperties.color
        case .settings:
            if row == 0 {
                return #colorLiteral(red: 0.8159197061, green: 0.1416606569, blue: 0.1822148324, alpha: 1)
            } else {
                return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
        case .permissions:
            return nil
        }
    }
    
    internal func setupImagesNames(section: Int, row: Int) -> String? {
        let section = sections[section]
        switch section {
        case .userAccaunt:
            if row == 0 {
                return "person.circle.fill"
            } else {
                return "link.circle.fill"
            }
        case .applicationInfo:
            return "info.circle.fill"
        case .settings:
            if row == 0 {
                return "text.bubble.fill"
            } else {
                return "paintpalette.fill"
            }
        case .permissions:
            return nil
        }
    }
    
    internal func setupLabelsText(section: Int, row: Int) -> String {
        let section = sections[section]
        switch section {
        case .userAccaunt:
            if row == 0 {
                return "Your Personal Account"
            } else {
                return "Personal Analytics"
            }
        case .applicationInfo:
            return "Application Info"
        case .settings:
            if row == 0 {
                return "Articles Notifications"
            } else {
                return "Appearance"
            }
        case .permissions:
            if row == 0 {
                return "Update Permissions"
            } else {
                return "Support"
            }
        }
    }
}
