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
protocol MainProfileViewControllerPresenterDefaultContentProtocol {
    func setupProfileImage() -> UIImage?
    func setupEmail() -> String
    func setupFullName() -> String
    func setupPhone() -> String
}



//MARK: - MainProfileViewControllerPresenterSegueContentProtocol protocol
protocol MainProfileViewControllerPresenterSegueContentProtocol {
    func setupSegueFullName(segue: UIStoryboardSegue) -> String
    func setupSegueEmail(segue: UIStoryboardSegue) -> String
    func setupSeguePhone(segue: UIStoryboardSegue) -> String
    func setupSegueImage(segue: UIStoryboardSegue) -> UIImage
}



//MARK: - MainProfileViewControllerPresenterTableViewMethodsSetupProtocol protocol
protocol MainProfileViewControllerPresenterTableViewMethodsSetupProtocol {
    func setupSectionHeaders(section: Int) -> String?
    func setupNumberOfRowsInSection() -> Int
    func setupNumberOfSections(section: Int) -> Int
    func setupImagesTintColors(section: Int, row: Int) -> UIColor
    func setupImagesNames(section: Int, row: Int) -> String?
    func setupLabelsText(section: Int, row: Int) -> String
    func setupSectionFooters(section: Int) -> String?
}



//MARK: - MainProfileViewControllerPresenterProtocol protocol
protocol MainProfileViewControllerPresenterProtocol: MainProfileViewControllerPresenterSegueContentProtocol, MainProfileViewControllerPresenterDefaultContentProtocol, MainProfileViewControllerPresenterTableViewMethodsSetupProtocol {}



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
    func setupSegueFullName(segue: UIStoryboardSegue) -> String {
        let destVC = segue.destination as! AccountVC
        let firstName = destVC.defaults.value(forKey: AccountVC.Keys.firstNameKey) as? String ?? ""
        let familyName = destVC.defaults.value(forKey: AccountVC.Keys.familyNameKey) as? String ?? ""
        return firstName + " " + familyName
    }
    
    func setupSegueEmail(segue: UIStoryboardSegue) -> String {
        let destVC = segue.destination as! AccountVC
        let email = destVC.defaults.value(forKey: AccountVC.Keys.emailKey) as? String ?? ":"
        return email
    }
    
    func setupSeguePhone(segue: UIStoryboardSegue) -> String {
        let destVC = segue.destination as! AccountVC
        let phone = destVC.defaults.value(forKey: AccountVC.Keys.phoneKey) as? String ?? ""
        return phone
    }
    
    func setupSegueImage(segue: UIStoryboardSegue) -> UIImage {
        let destVC = segue.destination as! AccountVC
        let data = destVC.defaults.object(forKey: AccountVC.Keys.userPhotoKey) as! NSData?
        if data != nil {
            return UIImage(data: (data!) as Data)!
        } else {
            return UIImage(systemName: "person.crop.circle")!
        }
    }
    
    
    //MARK: MainProfileViewControllerPresenterDefaultContentProtocol functions
    func setupFullName() -> String {
        return defaults.value(forKey: MainProfileViewController.Keys.fullNameKay.rawValue) as? String ?? ""
    }
    
    func setupProfileImage() -> UIImage? {
        let data = UserDefaults.standard.object(forKey: AccountVC.Keys.userPhotoKey) as! NSData?
        if data != nil {
            return UIImage(data: (data!) as Data)
        } else {
            return UIImage(systemName: "person.crop.circle")
        }
    }
    
    func setupEmail() -> String {
        if defaults.value(forKey: MainProfileViewController.Keys.emailKey.rawValue) == nil {
            return "Email:"
        } else {
            return "\(defaults.value(forKey: MainProfileViewController.Keys.emailKey.rawValue) ?? "")"
        }
    }
    
    func setupPhone() -> String {
        if defaults.value(forKey: MainProfileViewController.Keys.phoneKey.rawValue) == nil {
            return "Phone:"
        } else {
            return "\(defaults.value(forKey: MainProfileViewController.Keys.phoneKey.rawValue) ?? "")"
        }
    }
    
    
    //MARK: MainProfileViewControllerPresenterTableViewMethodsSetupProtocol functions
    func setupSectionFooters(section: Int) -> String? {
        let section = sections[section]
        switch section {
        case .userAccaunt:
            return nil
        case .applicationInfo:
            return "In this section, you can read about the application and its main functions."
        case .settings:
            return nil
        case .permissions:
            return "Permissions are necessary for the correct work of the application and the performance of all functions."
        }
    }
    
    func setupSectionHeaders(section: Int) -> String? {
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
    
    func setupNumberOfRowsInSection() -> Int {
        return sections.count
    }
    
    func setupNumberOfSections(section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .userAccaunt:
            return 2
        case .applicationInfo:
            return 1
        case .settings:
            return 1
        case .permissions:
            return 1
        }
    }
    
    func setupImagesTintColors(section: Int, row: Int) -> UIColor {
        let section = sections[section]
        switch section {
        case .userAccaunt:
            if row == 0 {
                return .red
            } else {
                return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        case .applicationInfo:
            return BasicProperties.color
        case .settings:
            return #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        case .permissions:
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }
    
    func setupImagesNames(section: Int, row: Int) -> String? {
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
            return "text.bubble.fill"
        case .permissions:
            return ""
        }
    }
    
    func setupLabelsText(section: Int, row: Int) -> String {
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
            return "Articles Notifications"
        case .permissions:
            return "Permissions"
        }
    }
}
