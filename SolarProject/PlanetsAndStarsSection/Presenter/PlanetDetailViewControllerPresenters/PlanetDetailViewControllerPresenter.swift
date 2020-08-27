//
//  PlanetDetailViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - PlanetDetailViewControllerPresenterContentSetupProtocol protocol
protocol PlanetDetailViewControllerPresenterContentSetupProtocol {
    func setupTitles() -> String
    func setupBasicContent() -> String
    func setupMostContent() -> String
    func setupSwitchedContent(with selectedIndex: Int) -> String
    func setupContentTypeInfo(with selectedIndex: Int) -> String
    func addViewToAnalytics()
    func setupBasicAdUnitId() -> String
}



//MARK: - PlanetDetailViewControllerPresenter main class
final class PlanetDetailViewControllerPresenter {
    
    //MARK: Index(from Model)
    let index = MenuContentModel.index
    
    
    //MARK: Content(from Model)
    let titles = MenuContentModel.planetsTitles
    let mainContent = MenuContentModel.MainContent.content
    let previewContent = MenuContentModel.PreviewContent.planetsPreviewContent
}



//MARK: - PlanetDetailViewControllerPresenter extension
extension PlanetDetailViewControllerPresenter: PlanetDetailViewControllerPresenterContentSetupProtocol {
    
    //MARK: Setup Content
    public func setupTitles() -> String {
        
        ///Setup Content
        return " " + titles[index]
    }
    
    public func setupBasicContent() -> String {
        return previewContent[index]
    }
    
    public func setupMostContent() -> String {
        return mainContent[index]
    }
    
    public func setupSwitchedContent(with selectedIndex: Int) -> String {
        switch selectedIndex {
        case 0:
            return setupMostContent()
        case 1:
            return setupBasicContent()
        default:
            return ""
        }
    }
    
    public func setupContentTypeInfo(with selectedIndex: Int) -> String {
        switch selectedIndex {
        case 0:
            return " Most Information".uppercased()
        case 1:
            return " Basic Information".uppercased()
        default:
            return ""
        }
    }
    
    public func setupSwitchedTitlesContent(with selectedIndex: Int) -> String {
        switch selectedIndex {
        case 0:
            return " " + setupTitles()
        case 1:
            return " " + setupTitles() + " Basics"
        default:
            return ""
        }
    }
    
    public func addViewToAnalytics() {
        
        ///I use  "index + 1"  beacouse index 0 is Sun index
        PersonalAnalyticsModel.shared.views[MenuContentModel.index + 1] += 1
        
        ///Save array
        defaults.set(PersonalAnalyticsModel.shared.views, forKey: "ViewsKey")
    }
    
    public func setupBasicAdUnitId() -> String {
        return MenuContentModel.basicPlanetsDetailadUnitID
    }
}
