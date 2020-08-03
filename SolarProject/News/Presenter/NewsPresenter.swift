//
//  NewsPresenter.swift
//  SolarProject
//
//  Created by Yaroslav on 28.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - NewsPresenterProtocol protocol
protocol NewsPresenterProtocol {
    func setupNumberOfSections() -> Int
    func setupTitlesForHeaders(section: Int) -> String?
    func setupNumberOfRowsInSection(section: Int) -> Int
}


//MARK: - NewsPresenter main class
final class NewsPresenter {}



//MARK: - NewsPresenterProtocol extension
extension NewsPresenter: NewsPresenterProtocol {
    func setupNumberOfRowsInSection(section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 1
        }
    }
    
    func setupNumberOfSections() -> Int {
        return 2
    }
    
    func setupTitlesForHeaders(section: Int) -> String? {
        if section == 0 {
            return "Space News"
        } else {
            return nil
        }
    }
}
