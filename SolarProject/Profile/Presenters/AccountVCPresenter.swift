//
//  AccountVCPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 05.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - MainProfileViewControllerPresenterProtocol protocol
protocol AccountVCPresenterProtocol {
    func presentImagePicker(for vc: UITableViewController)
}



//MARK: - MainProfileViewControllerPresenter
final class AccountVCPresenter {
    var imagePicker = UIImagePickerController()
    
    init(imagePicker: UIImagePickerController) {
        self.imagePicker = imagePicker
    }
}



//MARK: - AccountVCPresenterProtocol extension
extension AccountVCPresenter: AccountVCPresenterProtocol {
    internal func presentImagePicker(for vc: UITableViewController) {
        
        ///Setup UIAlertController
        let actionSheet = UIAlertController(title: nil, message: "How do you want to put the icon ?", preferredStyle: .actionSheet)
        
        ///Camera Action
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                ///Present ImagePicker
                self.imagePicker.sourceType = .camera
                vc.present(self.imagePicker, animated: true, completion: nil)
            } else {
                
                ///Show Error alert
                FastAlert.showBasic(title: "Error", message: "Camera is unavailable", vc: vc)
            }
        }
        
        ///Library Action
        let libraryAction = UIAlertAction(title: "Library", style: .default) { (action: UIAlertAction) in
            
            ///Present ImagePicker
            self.imagePicker.sourceType = .photoLibrary
            vc.present(self.imagePicker, animated: true, completion: nil)
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
        vc.present(actionSheet, animated: true)
    }
}
