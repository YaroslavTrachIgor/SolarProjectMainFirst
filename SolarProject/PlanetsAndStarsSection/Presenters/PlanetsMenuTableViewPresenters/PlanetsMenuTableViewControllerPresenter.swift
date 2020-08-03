//
//  PlanetsMenuTableViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - PlanetDetailViewControllerPresenter main class
final class PlanetsMenuTableViewControllerPresenter {
    
    //MARK: Index(from Model)
    let index = PlanetsMenuTableViewControllerModel.index
    
    //Content
    private let headers = PlanetsMenuTableViewControllerModel.planetsTitles
}



//MARK: - PlanetDetailViewControllerPresenter extension
extension PlanetsMenuTableViewControllerPresenter {
    
    
    //MARK: Setup Main Articles Menu Section Content
    internal func numberOfSections() -> Int {
        return 2
    }
    
    internal func setupSectionHeaders(section: Int) -> String {
        if section == 0 {
            return "Stars"
        } else {
            return "Planets"
        }
    }
    
    internal func setupPlanetsTitlesContent(indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            return PlanetsMenuTableViewControllerModel.StarsContent.title
        } else {
            return " " + headers[indexPath.row]
        }
    }
    
    internal func setupTextViewsContent(indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            return PlanetsMenuTableViewControllerModel.StarsContent.previewContent
        } else {
            return PlanetsMenuTableViewControllerModel.PreviewContent.planetsPreviewContent[indexPath.row]
        }
    }
    
    internal func setupNotificationButtonTitles(indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            return "Put notification on Sun article"
        } else {
            return "Put notification on \(headers[indexPath.row]) article"
        }
    }
    
    internal func setupSectionRows(section: Int) -> Int {
        if(section == 0) {
            return 1
        } else {
            return headers.count
        }
    }
    
    internal func setupImageCellPlanetDetailLabelContent(indexPath: IndexPath) -> String{
        if indexPath.row == 9 {
            return "Sun"
        } else {
            return headers[indexPath.row]
        }
    }
    
    internal func setupImageCellPlanetSubDetailLabelContent(indexPath: IndexPath) -> String {
        if indexPath.row == 9 {
            return "Star Sun"
        } else {
            return "Plantet " + headers[indexPath.row]
        }
    }
    
    
    //MARK: Setup MoreItems Content
    internal func setupMoreItemsNumberOfRows() -> Int{
        return PlanetsMenuTableViewControllerModel.MoreItemsContent.titles.count
    }
    
    internal func setupCollectionViewCellImageDownloadsContent(indexPath: IndexPath) -> String {
        return PlanetsMenuTableViewControllerModel.images[indexPath.row]
    }
    
    internal func setupMoreItemsBackColors(row: Int) -> UIColor {
        return PlanetsMenuTableViewControllerModel.MoreItemsContent.backColors[row]
    }
    
    internal func setupMoreItemsTitles(row: Int) -> String {
        return " " + PlanetsMenuTableViewControllerModel.MoreItemsContent.titles[row]
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
}
