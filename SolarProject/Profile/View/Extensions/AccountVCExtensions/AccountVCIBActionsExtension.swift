//
//  AccountVCIBActionsExtension.swift
//  SolarProject
//
//  Created by Yaroslav on 27.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import Parse

//MARK: - @IBActions
extension AccountVC {
    @IBAction func setPhotoButton(sender: Any) {
        
        ///Set ImagePicker delegate
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        ///Setup UIAlertController
        let actionSheet = UIAlertController(title: nil, message: "How do you want to put the icon ?", preferredStyle: .actionSheet)
        
        ///Camera Action
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                ///Present ImagePicker
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                
                ///Show Error alert
                AlertManeger.presentAlert(title: "Error", message: "Camera is unavailable", vc: self)
            }
        }
        
        ///Library Action
        let libraryAction = UIAlertAction(title: "Library", style: .default) { (action: UIAlertAction) in
            
            ///Present ImagePicker
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        ///Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ///Add all Actions
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cancelAction)
        
        ///Setup style
        actionSheet.setupBasicTint()
        
        ///Present ActionSheet
        self.present(actionSheet, animated: true)
    }
    
    @IBAction func share(_ sender: Any) {
        ActivityVCManeger.showBasic(content: setupShareTextFieldsContent(), for: self)
    }
    
    @IBAction func saveTextFieldContent(_ sender: UITextField) {
        let text = sender.text!
        
        switch sender.tag {
            case 0: defaults.set(text, forKey: Keys.firstNameKey)
            case 1: defaults.set(text, forKey: Keys.familyNameKey)
            case 2: defaults.set(text, forKey: Keys.emailKey)
            case 3: defaults.set(text, forKey: Keys.phoneKey)
            case 4: defaults.set(text, forKey: Keys.passwordKey)
            
            default: return
        }
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            ///Setup PFUser
            let user = PFUser()
            
            ///Save User info
            for textField in self.textFields {
                self.saveEmail(textField: textField, user: user)
                self.saveUsername(user: user)
                self.savePassword(textField: textField, user: user)
            }
            
            ///Sign Up
            self.signUpSetup(user: user)
        }
    }
}
