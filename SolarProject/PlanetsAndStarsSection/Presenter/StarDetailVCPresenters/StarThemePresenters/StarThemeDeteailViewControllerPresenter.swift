//
//  StarThemeDeteailViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 30.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - StarThemeDeteailViewControllerPresenterProtocol
protocol StarThemeDeteailViewControllerPresenterProtocol {
    
    ///Setup Content
    func setupTitleContent() -> String
    func setupTextViewContent() -> String
}


//MARK: - StarThemeDeteailViewControllerPresenter main class
final class StarThemeDeteailViewControllerPresenter {
    private let index = PlanetsMenuTableViewControllerModel.StarsContent.starThemeIndex
}


extension StarThemeDeteailViewControllerPresenter: StarThemeDeteailViewControllerPresenterProtocol {
    
    //MARK: Setup Content
    internal func setupTitleContent() -> String {
        return PlanetsMenuTableViewControllerModel.StarsContent.themesContentTitles[index]
    }
    
    internal func setupTextViewContent() -> String {
        return PlanetsMenuTableViewControllerModel.StarsContent.themesContent[index]
    }
}
