//
//  PlanetsMenuTableViewCellPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 29.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - PlanetsMenuTableViewCellPresenterProtocol protocol
protocol PlanetsMenuTableViewCellPresenterProtocol {
    func addReminder(title: String)
}



//MARK: - PlanetDetailViewControllerPresenter main class
final class PlanetsMenuTableViewCellPresenter {}



//MARK: - PlanetDetailViewControllerPresenter extension
extension PlanetsMenuTableViewCellPresenter: PlanetsMenuTableViewCellPresenterProtocol {
    internal func addReminder(title: String) {
        
        ///Setup new reminder Date
        let date = LocalizedDate("us", datePosix: "MMMM d  'at'  h:mm a")
        let content = "Date: " + date.returnDate()
        
        ///Add new reminder to remindersArray
        dates.append(content)
        reminders.append("Read about \(title)")
        
        ///Save new reminder
        defaults.set(reminders, forKey: "RemindersSaveKey")
        defaults.set(dates, forKey: "RemindersDatesSaveKey")
    }
}
