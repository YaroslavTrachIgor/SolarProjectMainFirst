//
//  PlanetsMenuTableViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - PlanetsMenuTableViewControllerPresenterMoreItemsProtocol protocol
protocol PlanetsMenuTableViewControllerPresenterMoreItemsProtocol {
    func setupMoreItemsNumberOfRows() -> Int
    func setupCollectionViewCellImageDownloadsContent(indexPath: IndexPath) -> String
    func setupMoreItemsBackColors(row: Int) -> UIColor
    func setupMoreItemsTitles(row: Int) -> String
    func setupMoreItemsButtonsTitles(row: Int) -> String
    func setupMoreItemsDescriptions(row: Int) -> String
    func setupSegues(row: Int) -> String
    func setupMoreCellBackImages(row: Int) -> UIImage
}



//MARK: - PlanetsMenuTableViewControllerPresenterProtocol protocol
protocol PlanetsMenuTableViewControllerPresenterProtocol: PlanetsMenuTableViewControllerPresenterMoreItemsProtocol {
    func setupSectionHeaders(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], section: Int) -> String
    func setupPlanetsTitlesContent(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], row: Int, section: Int) -> String
    func setupTextViewsContent(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], row: Int, section: Int) -> String
    func setupNotificationButtonTitles(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], row: Int, section: Int) -> String
    func setupSectionRows(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], section: Int) -> Int
    func setupImageCellPlanetDetailLabelContent(row: Int) -> String
    func setupImageCellPlanetSubDetailLabelContent(row: Int) -> String
}



//MARK: - PlanetDetailViewControllerPresenter main class
final class PlanetsMenuTableViewControllerPresenter {
    
    //MARK: Index(from Model)
    let index = PlanetsMenuTableViewControllerModel.index
    
    //Content
    private let headers = PlanetsMenuTableViewControllerModel.planetsTitles
}



//MARK: PlanetsMenuTableViewController extension
extension PlanetsMenuTableViewController {
    
    //MARK: MainPlanetsMenuSections enum
    enum MainPlanetsMenuSections {
        case planets
        case stars
    }
}



//MARK: - PlanetDetailViewControllerPresenter extension
extension PlanetsMenuTableViewControllerPresenter: PlanetsMenuTableViewControllerPresenterProtocol {
    
    
    //MARK: Setup Main Articles Menu Section Content
    internal func setupSectionHeaders(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], section: Int) -> String {
        let section = sections[section]
        switch section {
        case .stars:
            return "Stars"
        case .planets:
            return "Planets"
        }
    }
    
    internal func setupPlanetsTitlesContent(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], row: Int, section: Int) -> String {
        let section = sections[section]
        switch section {
        case .stars:
            return PlanetsMenuTableViewControllerModel.StarsContent.title
        case .planets:
            return " " + headers[row]
        }
    }
    
    internal func setupTextViewsContent(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], row: Int, section: Int) -> String {
        let section = sections[section]
        switch section {
        case .stars:
            return PlanetsMenuTableViewControllerModel.StarsContent.previewContent
        case .planets:
            return PlanetsMenuTableViewControllerModel.PreviewContent.planetsPreviewContent[row]
        }
    }
    
    internal func setupNotificationButtonTitles(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], row: Int, section: Int) -> String {
        let section = sections[section]
        switch section {
        case .stars:
            return "Put notification on Sun article"
        case .planets:
            return "Put notification on \(headers[row]) article"
        }
    }
    
    internal func setupSectionRows(sections: [PlanetsMenuTableViewController.MainPlanetsMenuSections], section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .stars:
            return 1
        case .planets:
            return headers.count
        }
    }
    
    internal func setupImageCellPlanetDetailLabelContent(row: Int) -> String {
        switch row {
        case 9:
            return "Sun"
        default:
            return headers[row]
        }
    }
    
    internal func setupImageCellPlanetSubDetailLabelContent(row: Int) -> String {
        switch row {
        case 9:
            return "Star Sun"
        default:
            return "Plantet " + headers[row]
        }
    }
    
    
    //MARK: Setup MoreItems Content
    internal func setupMoreItemsNumberOfRows() -> Int {
        return PlanetsMenuTableViewControllerModel.MoreItemsContent.titles.count
    }
    
    internal func setupCollectionViewCellImageDownloadsContent(indexPath: IndexPath) -> String {
        return PlanetsMenuTableViewControllerModel.images[indexPath.row]
    }
    
    internal func setupMoreItemsBackColors(row: Int) -> UIColor {
        return PlanetsMenuTableViewControllerModel.MoreItemsContent.backColors[row]
    }
    
    internal func setupMoreItemsTitles(row: Int) -> String {
        return PlanetsMenuTableViewControllerModel.MoreItemsContent.titles[row]
    }
    
    internal func setupMoreItemsButtonsTitles(row: Int) -> String {
        return PlanetsMenuTableViewControllerModel.MoreItemsContent.buttonsTitles[row]
    }
    
    internal func setupMoreItemsDescriptions(row: Int) -> String {
        return PlanetsMenuTableViewControllerModel.MoreItemsContent.titlesDescriptions[row]
    }
    
    internal func setupSegues(row: Int) -> String {
        return PlanetsMenuTableViewControllerModel.MoreItemsContent.segues[row]
    }
    
    internal func setupMoreCellBackImages(row: Int) -> UIImage {
        return PlanetsMenuTableViewControllerModel.MoreItemsContent.images[row]
    }
}
