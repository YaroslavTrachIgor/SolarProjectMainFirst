//
//  RemindersTableViewProtocolsExtension.swift
//  SolarProject
//
//  Created by Yaroslav on 27.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import SPStorkController

//MARK: - UITableViewDelegate, UITableViewDataSource extension
extension RemindersViewController: UITableViewDelegate, UITableViewDataSource {
    internal func numberOfSections(in tableView: UITableView) -> Int {
        
        ///number Of Sections
        return sections.count
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        ///Set header title
        return presenter.setupHeaders(sections: sections, section: section)
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        ///Setup number Of Rows In Section
        return presenter.setupNumperOfRows(sections: sections, isSearching: isSearching, searchedArticle: searchedArticle, section: section)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTableViewCell") as! RemindersTableViewCell
        let subtitle     = cell.subtitleLabel!
        let title        = cell.titleLabel!
        let contentBack  = cell.reminderContentBack!
        
        ///Setup cell
        setupRemindersContent(cell: cell, row: indexPath.row, section: indexPath.section)
        setupReminderViewContentBack(contentBack: contentBack, section: indexPath.section)
        setupSubtitleLabel(subtitle: subtitle)
        setupTitleLabel(title: title)
        setupBackImageView(backImageView: cell.backImageView, section: indexPath.section)
        
        ///Setup cell
        cell.backgroundColor = .clear
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let section = sections[indexPath.section]
            switch section {
            case .reminders:
                ///Set deleted indexes
                deletedIndex = indexPath.row
                deletedIndexPath = indexPath
                
                let transitonDelegate = SPStorkTransitioningDelegate()
                
                ///Setup transitonDelegate
                let deletevc = storyboard?.instantiateViewController(identifier: "DeleteVC") as! DeleteVC
                transitonDelegate.customHeight = 240
                transitonDelegate.cornerRadius = 9
                
                ///Setup deletevc
                deletevc.transitioningDelegate = transitonDelegate
                deletevc.modalPresentationStyle = .custom
                deletevc.modalPresentationCapturesStatusBarAppearance = true
                
                self.present(deletevc, animated: true, completion: nil)
            case .completed:
                let row = indexPath.row
                
                ///Setup Semaphore
                let semaphore = DispatchSemaphore(value: 1)
                let mainQueue = DispatchQueue.main
                
                mainQueue.async {
                    semaphore.wait() //-1
                    
                    ///reload remindersMenuTableView data
                    self.remindersMenuTableView.reloadData()
                    
                    semaphore.signal() //+1
                }
                
                mainQueue.async {
                    semaphore.wait() //-1
                    
                    ///Remove from array
                    completedDates.remove(at: row)
                    completedReminders.remove(at: row)
                    
                    semaphore.signal() //+1
                }
                
                mainQueue.async {
                    semaphore.wait() //-1
                    
                    ///Remove from remindersMenuTableView
                    self.remindersMenuTableView.beginUpdates()
                    self.remindersMenuTableView.deleteRows(at: [indexPath], with: .right)
                    self.remindersMenuTableView.endUpdates()
                    
                    semaphore.signal() //+1
                }
                
                mainQueue.async {
                    semaphore.wait() //-1
                    
                    self.presenter.saveReminders()
                    
                    semaphore.signal() //+1
                }
            }
        }
    }
    
    internal func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        ///Setup done action
        let share = shareAction(at: indexPath, for: self)
        
        ///Setup all swipe actions
        return UISwipeActionsConfiguration(actions: [share])
    }
}

