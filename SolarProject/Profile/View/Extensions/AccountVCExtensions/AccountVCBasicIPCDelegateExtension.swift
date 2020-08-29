//
//  AccountVCBasicIPCDelegateExtension.swift
//  SolarProject
//
//  Created by Yaroslav on 27.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Setup BasicImagePickerControllerDelegate typealias
typealias BasicIPCDelegate = UINavigationControllerDelegate & UIImagePickerControllerDelegate



//MARK: - BasicIPCDelegate extension
extension AccountVC: BasicIPCDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let globalQueue = DispatchQueue.global()
        let mainQueue = DispatchQueue.main
        let semaphore = DispatchSemaphore(value: 1)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        mainQueue.async {
            semaphore.wait()
            
            self.userPhoto = image
            
            semaphore.signal()
        }
        
        ///Save Image
        mainQueue.async {
            semaphore.wait()
            
            ///Show new User Photo
            self.userPhotoImageView.image = self.userPhoto
            
            ///Dismiss picker
            picker.dismiss(animated: true, completion: nil)
            
            semaphore.signal()
        }
        
        ///Save Image
        globalQueue.async {
            semaphore.wait()
            
            let imageData: NSData = image.pngData()! as NSData
            self.defaults.set(imageData, forKey: Keys.userPhotoKey)
            
            semaphore.signal()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
