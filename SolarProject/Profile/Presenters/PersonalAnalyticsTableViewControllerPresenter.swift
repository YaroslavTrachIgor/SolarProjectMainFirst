//
//  PersonalAnalyticsTableViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav on 01.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - PersonalAnalyticsTableViewControllerPresenterProtocol protocol
protocol PersonalAnalyticsTableViewControllerPresenterProtocol {
    func setupHeadersForSections(section: Int) -> String?
    func setupFootersForSections(section: Int) -> String?
    func setupNumberOfRowsInSection(section: Int) -> Int
    func setupCell(red: () -> (), green: () -> (), normal: () -> (), zero: () -> (), indexPath: IndexPath)
    func setupTitleLabelsContent(indexPath: IndexPath) -> String
    func setupSubTitleLabelsContent(indexPath: IndexPath) -> String
    func setupViews(indexPath: IndexPath) -> String
    func setupChartColors() -> [UIColor]
}



//MARK: - PersonalAnalyticsTableViewControllerPresenter main class
final class PersonalAnalyticsTableViewControllerPresenter {
    let sections: [PersonalAnalyticsTableViewController.SectionType]
    
    init(sections: [PersonalAnalyticsTableViewController.SectionType]) {
        self.sections = sections
    }
}



//MARK: - PersonalAnalyticsTableViewControllerPresenterProtocol extension
extension PersonalAnalyticsTableViewControllerPresenter: PersonalAnalyticsTableViewControllerPresenterProtocol {
    internal func setupHeadersForSections(section: Int) -> String? {
        let section = sections[section]
        switch section {
        case .chart:
            return "Chart"
        case .defaultCells:
            return "Views Count"
        }
    }
    
    internal func setupFootersForSections(section: Int) -> String? {
        let section = sections[section]
        switch section {
        case .chart:
            return "In this section, you can view your analytics as chart."
        case .defaultCells:
            return "In this section, you can find the most interesting articles for you on views, which were typed from the very beginning of using the application."
        }
    }
    
    internal func setupNumberOfRowsInSection(section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .chart:
            return 1
        case .defaultCells:
            return PersonalAnalyticsModel.titles.count
        }
    }
    
    internal func setupCell(red: () -> (), green: () -> (), normal: () -> (), zero: () -> (), indexPath: IndexPath) {
        if ((PersonalAnalyticsModel.shared.views.reduce(0, +) / PersonalAnalyticsModel.shared.views.count)) - 2 >= PersonalAnalyticsModel.shared.views[indexPath.row] {
            
            ///Setup First CountView type
            red()
            
        } else if ((PersonalAnalyticsModel.shared.views.reduce(0, +) / PersonalAnalyticsModel.shared.views.count) + 2) >= PersonalAnalyticsModel.shared.views[indexPath.row] {
            
            ///Setup Second CountView type
            normal()
            
            
        } else if PersonalAnalyticsModel.shared.views[indexPath.row] == 0 {
            zero()
            
        } else {
            
            ///Setup Third CountView type
            green()
        }
    }
    
    internal func setupTitleLabelsContent(indexPath: IndexPath) -> String {
        return PersonalAnalyticsModel.titles[indexPath.row]
    }
    
    
    internal func setupSubTitleLabelsContent(indexPath: IndexPath) -> String {
        return PersonalAnalyticsModel.subtitles[indexPath.row]
    }
    
    
    internal func setupViews(indexPath: IndexPath) -> String {
        return String(PersonalAnalyticsModel.shared.views[indexPath.row])
    }
    
    internal func setupChartColors() -> [UIColor] {
        return [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)]
    }
}
