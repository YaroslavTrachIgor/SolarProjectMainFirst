//
//  FullPhotoImageSingletone.swift
//  SolarProject
//
//  Created by Yaroslav on 27.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - FullPhotoImageSingletone main class
final class FullPhotoImageSingletone {
    
    //MARK:Shared
    static let shared = FullPhotoImageSingletone()
    
    
    //MARK: Private Init
    private init() {}
    
    
    //MARK: Public
    public var image = UIImage()
}
