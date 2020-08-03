//
//  StarDeteailViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 29.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - PlanetDetailViewControllerPresenterProtocol protocol
protocol StarDetailVCPresenterContentSetupProtocol {
    func setupMostContent() -> String
    func setupBasicContent() -> String
    func setupHistoryContent() -> String
}



//MARK: - PlanetDetailViewControllerPresenterProtocol protocol
protocol StarDetailVCPresenterProtocol: StarDetailVCPresenterContentSetupProtocol {
    func setupBasicAddUnitId() -> String
}


//MARK: - PlanetDetailViewControllerPresenter main class
final class StarDetailVCPresenter {}



//MARK: - PlanetDetailViewControllerPresenter extension
extension StarDetailVCPresenter: StarDetailVCPresenterProtocol {
    
    //MARK: Setup AddUnitId
    internal func setupBasicAddUnitId() -> String {
        return PlanetsMenuTableViewControllerModel.StarsContent.basicStartDetailadUnitID
    }
    
    
    //MARK: Setup content
    internal func setupMostContent() -> String {
        return PlanetsMenuTableViewControllerModel.StarsContent.mostContent
    }
    
    internal func setupBasicContent() -> String {
        return PlanetsMenuTableViewControllerModel.StarsContent.basicContent
    }
    
    internal func setupHistoryContent() -> String {
        return PlanetsMenuTableViewControllerModel.StarsContent.historyContent
    }
    
    internal func setupSwitchedContent(with selectedIndex: Int) -> String {
        switch selectedIndex {
        case 0:
            return setupMostContent()
        case 1:
            return setupBasicContent()
        case 2:
            return setupHistoryContent()
        default:
            return ""
        }
    }
}
