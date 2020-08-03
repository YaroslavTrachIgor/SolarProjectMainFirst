//
//  RemindersViewControllerPresenter.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 02.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - RemindersViewControllerPresenter main class
final class RemindersViewControllerPresenter {}



//MARK: - RemindersViewControllerPresenterProtocol main class
extension RemindersViewControllerPresenter {
    func setupNumperOfRows(isSearching: Bool, searchedArticle: [String], section: Int) -> Int {
        if isSearching {
            return searchedArticle.count
        } else {
            if section == 0 {
                return reminders.count
            } else {
                return completedReminders.count
            }
        }
    }
    
    func setupHeaders(section: Int) -> String {
        if section == 0 {
            return "Your Reminders"
        } else {
            return "Completed Reminders"
        }
    }
    
    func setupRemindersContent(row: Int, section: Int) -> String {
        if section == 0 {
            return reminders[row]
        } else {
            return completedReminders[row]
        }
    }
    
    func setupRemindersDatesContent(row: Int, section: Int) -> String {
        if section == 0 {
            return dates[row]
        } else {
            return completedDates[row]
        }
    }
    
    func setupNumberOfSections() -> Int {
        return 2
    }
    
    func setupSavedRemindersArrays(remindersSaveKey: String, remindersDatesSaveKey: String, remindersCompletedDatesSaveKey: String, remindersCompletedSaveKey: String) {
        reminders            = defaults.value(forKey: remindersSaveKey) as? [String] ?? ["Example reminder"]
        dates                = defaults.value(forKey: remindersDatesSaveKey) as? [String] ?? ["Date: "]
        completedDates       = defaults.value(forKey: remindersCompletedDatesSaveKey) as? [String] ?? []
        completedReminders   = defaults.value(forKey: remindersCompletedSaveKey) as? [String] ?? []
    }
    
    func inhertRow(method reloadTable: () -> Void, text: String?) {
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
    
    func shareContent(at indexPath: IndexPath) -> String {
        let row = indexPath.row
        
        return """
                \(reminders[row])
                \(dates[row])
                """
    }
}



//MARK: - Main functions
extension RemindersViewControllerPresenter {
    public func saveReminders() {
        defaults.set(dates,                 forKey: RemindersViewController.Keys.remindersDatesSaveKey.rawValue)
        defaults.set(reminders,             forKey: RemindersViewController.Keys.remindersSaveKey.rawValue)
        defaults.set(completedDates,        forKey: RemindersViewController.Keys.remindersCompletedDatesSaveKey.rawValue)
        defaults.set(completedReminders,    forKey: RemindersViewController.Keys.remindersCompletedSaveKey.rawValue)
    }
}
