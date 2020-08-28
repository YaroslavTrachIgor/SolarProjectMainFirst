//
//  AccountVCGIDSignInDelegateExtension.swift
//  SolarProject
//
//  Created by Yaroslav on 27.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

//MARK: - GIDSignInDelegate extension
extension AccountVC: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        ///Check for errors
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                
                ///Show error alert
                AlertManeger.presentAlert(title: "Error", message: "\(error.localizedDescription)", vc: self)
            }
            return
        }
        
        ///Perform any operations on signed in user here.
        let givenName    = user.profile.givenName
        let familyName   = user.profile.familyName
        let email        = user.profile.email
        
        
        //MARK: Setup Google Email
        for textField in textFields {
            if textField.tag == 2 {
                
                ///Set textField text
                textField.text = email
                
                ///Save email
                defaults.set(textField.text, forKey: Keys.emailKey)
            }
        }
        
        
        //MARK: Setup Google Given Name
        ///Set firstNameTextField text
        firstNameTextField.text = familyName
        
        ///Save firstName
        defaults.set(familyName, forKey: Keys.firstNameKey)
        
        
        //MARK: Setup Google Family Name
        ///Set surNameTextField text
        surNameTextField.text = givenName
        
        ///Save familyName
        defaults.set(givenName, forKey: Keys.familyNameKey)
    }
}

