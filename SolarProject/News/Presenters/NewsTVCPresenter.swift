//
//  NewsTVCPresenter.swift
//  SolarProject
//
//  Created by Yaroslav on 17.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - NewsTVCPresenterProtocol protocol
protocol NewsTVCPresenterProtocol {
    func setupStringSiteLink() -> String 
    func setupNumberOfRowsInSection(section: Int) -> Int
    func setupTitleForFooter(section: Int) -> String?
    func setupTitleForHeader(section: Int) -> String?
}



//MARK: - NewsTVCPresenter main class
final class NewsTVCPresenter {
    var sections: [NewsTableViewController.SectionType]
    
    
    //MARK: Init
    init(sections: [NewsTableViewController.SectionType]) {
        self.sections = sections
    }
}



//MARK: - NewsTVCPresenterProtocol protocol
extension NewsTVCPresenter: NewsTVCPresenterProtocol {
    
    //MARK: Internal
    func setupStringSiteLink() -> String {
        return "https://spacenews.com"
    }
    
    internal func setupNumberOfRowsInSection(section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .news:
            return 4
        case .site:
            return 1
        }
    }
    
    internal func setupTitleForFooter(section: Int) -> String? {
        let sectionType = sections[section]
        switch sectionType {
        case .news:
            return nil
        case .site:
            return "In this section you can find a link to a site that contains all the news content that was taken for this application."
        }
    }
    
    internal func setupTitleForHeader(section: Int) -> String? {
        let sectionType = sections[section]
        switch sectionType {
        case .news:
            return "News"
        case .site:
            return "Website"
        }
    }
}
