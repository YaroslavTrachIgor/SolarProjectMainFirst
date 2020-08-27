//
//  SunThemesMenuTBVCPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 30.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - SunThemesMenuTBVCPresenterProtocol protocol
protocol SunThemesMenuTBVCPresenterProtocol {
    func setupContentTitle(indexPath: IndexPath) -> String
    func setupPreviewContent(indexPath: IndexPath) -> String
    func setupNumberOfRowsInSection() -> Int
    func setupStarThemeIndex(indexPath: IndexPath)
}



//MARK: - SunThemesMenuTBVCPresenter main class
final class SunThemesMenuTBVCPresenter {
    
    //MARK: Content
    private let titles = MenuContentModel.StarsContent.themesContentTitles
}



//MARK: - SunThemesMenuTBVCPresenterProtocol extension
extension SunThemesMenuTBVCPresenter: SunThemesMenuTBVCPresenterProtocol {
    internal func setupContentTitle(indexPath: IndexPath) -> String {
        
        ///Setup basic content
        return " " + titles[indexPath.row]
    }
    
    internal func setupPreviewContent(indexPath: IndexPath) -> String {
        
        ///Setup basic content
        return MenuContentModel.StarsContent.themesContent[indexPath.row]
    }
    
    internal func setupNumberOfRowsInSection() -> Int {
        return titles.count
    }
    
    internal func setupStarThemeIndex(indexPath: IndexPath) {
        MenuContentModel.StarsContent.starThemeIndex = indexPath.row
    }
}
