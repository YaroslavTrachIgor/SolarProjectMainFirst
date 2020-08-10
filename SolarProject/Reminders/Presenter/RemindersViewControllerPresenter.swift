//
//  RemindersViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 02.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - RemindersViewControllerPresenterProtocol protocol
protocol RemindersViewControllerPresenterProtocol {
    func setupNumperOfRows(sections: [RemindersViewController.RemindersMenuSectionType], isSearching: Bool, searchedArticle: [String], section: Int) -> Int
    func setupHeaders(sections: [RemindersViewController.RemindersMenuSectionType], section: Int) -> String
    func setupRemindersContent(sections: [RemindersViewController.RemindersMenuSectionType], row: Int, section: Int) -> String
    func setupRemindersDatesContent(sections: [RemindersViewController.RemindersMenuSectionType], row: Int, section: Int) -> String
    func setupSavedRemindersArrays(remindersSaveKey: String, remindersDatesSaveKey: String, remindersCompletedDatesSaveKey: String, remindersCompletedSaveKey: String)
    func inhertRow(method reloadTable: () -> Void, text: String?)
    func shareContent(at indexPath: IndexPath) -> String
    func saveReminders()
}



//MARK: - RemindersViewControllerPresenter main class
final class RemindersViewControllerPresenter {}



//MARK: - RemindersViewController extension
extension RemindersViewController {
    
    //MARK: RemindersMenuSectionType enum
    enum RemindersMenuSectionType {
        case reminders
        case completed
    }
}



//MARK: - RemindersViewControllerPresenterProtocol main class
extension RemindersViewControllerPresenter: RemindersViewControllerPresenterProtocol {
    
    //MARK: Internal
    internal func setupNumperOfRows(sections: [RemindersViewController.RemindersMenuSectionType], isSearching: Bool, searchedArticle: [String], section: Int) -> Int {
        if isSearching {
            return searchedArticle.count
        } else {
            let section = sections[section]
            switch section {
            case .reminders:
                return reminders.count
            case .completed:
                return completedReminders.count
            }
        }
    }
    
    internal func setupHeaders(sections: [RemindersViewController.RemindersMenuSectionType], section: Int) -> String {
        let section = sections[section]
        switch section {
        case .reminders:
            return "Your Reminders"
        case .completed:
            return "Completed Reminders"
        }
    }
    
    internal func setupRemindersContent(sections: [RemindersViewController.RemindersMenuSectionType], row: Int, section: Int) -> String {
        let section = sections[section]
        switch section {
        case .reminders:
            return reminders[row]
        case .completed:
            return completedReminders[row]
        }
    }
    
    internal func setupRemindersDatesContent(sections: [RemindersViewController.RemindersMenuSectionType], row: Int, section: Int) -> String {
        let section = sections[section]
        switch section {
        case .reminders:
            return dates[row]
        case .completed:
            return completedDates[row]
        }
    }
    
    internal func setupSavedRemindersArrays(remindersSaveKey: String, remindersDatesSaveKey: String, remindersCompletedDatesSaveKey: String, remindersCompletedSaveKey: String) {
        reminders            = defaults.value(forKey: remindersSaveKey) as? [String] ?? ["Example reminder"]
        dates                = defaults.value(forKey: remindersDatesSaveKey) as? [String] ?? ["Date: "]
        completedDates       = defaults.value(forKey: remindersCompletedDatesSaveKey) as? [String] ?? []
        completedReminders   = defaults.value(forKey: remindersCompletedSaveKey) as? [String] ?? []
    }
    
    internal func inhertRow(method reloadTable: () -> Void, text: String?) {
        reloadTable()
        
        ///Append new reminder in remindersArray
        reminders.append(text!)
        
        ///Setup dates
        let date = LocalizedDate("us", datePosix: "MMMM d  'at'  h:mm a")
        let content = "Date: " + date.returnDate()
        
        ///Append new date in datesArray
        dates.append(content)
        
        ///Save arrays
        saveReminders()
    }
    
    internal func shareContent(at indexPath: IndexPath) -> String {
        let row = indexPath.row
        
        return """
                \(reminders[row])
                \(dates[row])
                """
    }
    
    //MARK: Public
    public func saveReminders() {
        defaults.set(dates,                 forKey: RemindersViewController.Keys.remindersDatesSaveKey.rawValue)
        defaults.set(reminders,             forKey: RemindersViewController.Keys.remindersSaveKey.rawValue)
        defaults.set(completedDates,        forKey: RemindersViewController.Keys.remindersCompletedDatesSaveKey.rawValue)
        defaults.set(completedReminders,    forKey: RemindersViewController.Keys.remindersCompletedSaveKey.rawValue)
    }
}
