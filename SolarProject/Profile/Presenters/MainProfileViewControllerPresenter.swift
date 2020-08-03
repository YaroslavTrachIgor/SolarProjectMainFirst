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
    func setupImagesNames(section: Int, row: Int) -> String
    func setupLabelsText(section: Int, row: Int) -> String
}



//MARK: - MainProfileViewControllerPresenterProtocol protocol
protocol MainProfileViewControllerPresenterProtocol: MainProfileViewControllerPresenterSegueContentProtocol, MainProfileViewControllerPresenterDefaultContentProtocol, MainProfileViewControllerPresenterTableViewMethodsSetupProtocol {}



//MARK: - MainProfileViewControllerPresenter
final class MainProfileViewControllerPresenter {}



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
        let email = destVC.defaults.value(forKey: AccountVC.Keys.emailKey) as? String ?? ""
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
            return UIImage(systemName: "person")!
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
            return UIImage(systemName: "person")
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
    func setupSectionHeaders(section: Int) -> String? {
        if section == 0 {
            return "User Account"
        } else {
            return "About Application"
        }
    }
    
    func setupNumberOfRowsInSection() -> Int {
        return 2
    }
    
    func setupNumberOfSections(section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 2
        }
    }
    
    func setupImagesTintColors(section: Int, row: Int) -> UIColor {
        if section == 0 {
            if row == 0 {
                return .red
            } else {
                return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        } else {
            if row == 0 {
                return BasicProperties.color
                
            } else {
                return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
        }
    }
    
    func setupImagesNames(section: Int, row: Int) -> String {
        if section == 0 {
            if row == 0 {
                return "person.circle.fill"
            } else {
                return "link.circle.fill"
            }
        } else {
            if row == 0 {
                return "info.circle.fill"
                
            } else {
                return "cart.fill"
            }
        }
    }
    
    func setupLabelsText(section: Int, row: Int) -> String {
        if section == 0 {
            if row == 0 {
                return "Your Personal Account"
            } else {
                return "Personal Analytics"
            }
        } else {
            if row == 0 {
                return "Application Info"
                
            } else {
                return "Application Permissions"
            }
        }
    }
}
