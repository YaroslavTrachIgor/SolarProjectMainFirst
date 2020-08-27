//
//  SunImagesPresenter.swift
//  SolarProject
//
//  Created by Yaroslav on 25.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - SunImagesPresenterProtocol protocol
protocol SunImagesPresenterProtocol {
    func setupNemberOfRows() -> Int
    func setupFooter() -> String
    func setupHeader() -> String
    func numberOfSections() -> Int
}



//MARK: - SunImagesPresenter main class
final class SunImagesPresenter {}



//MARK: - SunImagesPresenterProtocol extension
extension SunImagesPresenter: SunImagesPresenterProtocol {
    internal func setupNemberOfRows() -> Int {
        return MenuContentModel.StarsContent.imagesURLs.count
    }
    
    internal func setupFooter() -> String {
        return "In the table you can see different photos of the Sun. By clicking on a cell, you can open a larger picture."
    }
    
    internal func setupHeader() -> String {
        return MenuContentModel.StarsContent.title + " Images"
    }
    
    internal func numberOfSections() -> Int {
        /// #warning Incomplete implementation, return the number of sections
        ///Set number Of Sections
        return 1
    }
}
