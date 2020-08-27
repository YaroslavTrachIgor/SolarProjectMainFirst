//
//  AppearancePresenter.swift
//  SolarProject
//
//  Created by Yaroslav on 20.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - AppearancePresenterProtocol
public protocol AppearancePresenterProtocol {
    func setupNumberOfItems() -> Int
    func setupNumberOfSections() -> Int
    func saveColor(row: Int)
    func setupItemsBackgroundColors(row: Int) -> UIColor
}


//MARK: - AppearancePresenter main class
final class AppearancePresenter {
    
    //MARK: Init
    init() {}
}



//MARK: - AppearancePresenterProtocol extension
extension AppearancePresenter: AppearancePresenterProtocol {
    internal func setupNumberOfItems() -> Int {
        return 1
    }
    
    internal func setupNumberOfSections() -> Int {
        return AppearenceModel.colors.count
    }
    
    internal func saveColor(row: Int) {
        BasicProperties.color = AppearenceModel.colors[row]
        defaults.setValue(BasicProperties.color, forKey: "BasicPropertiesColorKey")
    }
    
    internal func setupItemsBackgroundColors(row: Int) -> UIColor {
        return AppearenceModel.colors[row]
    }
}
