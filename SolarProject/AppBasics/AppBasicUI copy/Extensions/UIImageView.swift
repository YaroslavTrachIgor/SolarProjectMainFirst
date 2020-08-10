//
//  UIImageView.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 07.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit


//MARK: - Setup ProfileImageView
public extension UIImageView {
    func setupProfileImageView() {
        
        ///Setup border
        layer.borderColor = BasicProperties.color.cgColor
        layer.borderWidth = 5.5
        
        ///Set corners
        layer.cornerRadius = frame.width / 2
        
        ///Setup shadow
        imageViewShadow()
    }
}


//MARK: - UIImageView image download with url 
public extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}