//
//  PlanetsImagesCollectionViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav on 29.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: PlanetsImagesCollectionViewControllerPresenterProtocol protocol
protocol PlanetsImagesCollectionViewControllerPresenterProtocol {
    func setupImagesURLs(row: Int) -> String
    func setupNumberOfSections() -> Int
    func setupNumberOfItemsInSection() -> Int
}



//MARK: - PlanetsImagesCollectionViewControllerPresenter main class
final class PlanetsImagesCollectionViewControllerPresenter {}



//MARK: PlanetsImagesCollectionViewControllerPresenterProtocol extension
extension PlanetsImagesCollectionViewControllerPresenter: PlanetsImagesCollectionViewControllerPresenterProtocol {
    func setupImagesURLs(row: Int) -> String {
        return MenuContentModel.mainPlanetsImagesURLArray[MenuContentModel.index][row]
    }
    
    func setupNumberOfItemsInSection() -> Int {
        return MenuContentModel.mainPlanetsImagesURLArray[MenuContentModel.index].count
    }
    
    func setupNumberOfSections() -> Int {
        return 1
    }
}
