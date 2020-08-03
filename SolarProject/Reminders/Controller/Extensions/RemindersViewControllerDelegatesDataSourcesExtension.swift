//
//  RemindersViewControllerDelegatesDataSourcesExtension.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift

//MARK: - UITableViewDelegate, UITableViewDataSource extension
extension RemindersViewController: UITableViewDelegate, UITableViewDataSource {
    internal func numberOfSections(in tableView: UITableView) -> Int {
        
        ///number Of Sections
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        ///Set header title
        return "Your Reminders"
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        ///Setup number Of Rows In Section
        if isSearching {
            return searchedArticle.count
        } else {
            return reminders.count
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTableViewCell") as! RemindersTableViewCell
        let row = indexPath.row
        
        let subtitle = cell.subtitleLabel!
        let title = cell.titleLabel!
        
        ///Setup cell
        if isSearching {
            
            ///Set cell content when searching
            subtitle.text = ""
            title.text = searchedArticle[row]
        } else {
            
            ///Set default cell content
            title.text = reminders[row]
            subtitle.text = dates[row]
        }
        
        ///Setup Shadow for reminderContentBack
        cell.reminderContentBack.viewShadows()
        cell.reminderContentBack.layer.shadowColor = BasicProperties.color.cgColor
        cell.reminderContentBack.layer.shadowRadius = 5
        cell.reminderContentBack.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        ///Set backgroundColor for reminderContentBack
        cell.reminderContentBack.backgroundColor = BasicProperties.color
        
        ///Set cornerRadius for reminderContentBack
        cell.reminderContentBack.layer.cornerRadius = BasicProperties.cornerRadius + 8
        
        
        ///Setup Shadow for labels
        subtitle.labelShadow()
        subtitle.layer.shadowColor = subtitle.textColor!.cgColor
        
        title.labelShadow()
        title.layer.shadowColor = title.textColor.cgColor
        
        ///Set textColor for subtitle
        subtitle.textColor = #colorLiteral(red: 0.8760064758, green: 0.8760064758, blue: 0.8760064758, alpha: 1)
        
        ///Set textColor for title
        title.textColor = .white
        
        
        ///Setup Design Views
        setupDesignViews(cell: cell)
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            ///Setup deleteAlertController
            let deleteAlertController = UIAlertController(
                title: "Delete Reminder",
                message: "Are you sure you want to delete the reminder ?",
                preferredStyle: .actionSheet)
            
            ///Setup deleteAlertAction
            let deleteAlertAction = UIAlertAction(
            title: "Delete",
            style: .destructive) { (_) in
                ///Setup Semaphore
                let semaphore = DispatchSemaphore(value: 1)
                let mainQueue = DispatchQueue.main
                
                mainQueue.async {
                    semaphore.wait() //-1
                    
                    self.presenter.deleteRow(indexPath: indexPath)
                    
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
                    
                    ///Setup deleteBunner
                    let deleteBunner = StatusBarNotificationBanner(
                        title: "THE  REMINDER  HAS  BEEN  DELETED",
                        style: .danger,
                        colors: nil)
                    
                    ///Setup deleteBunner properties
                    deleteBunner.dismissOnTap = true
                    deleteBunner.autoDismiss = true
                    
                    ///Show Banner
                    deleteBunner.show()
                    
                    semaphore.signal() //+1
                }
            }
            
            ///Setup cancelAlertAction
            let cancelAlertAction = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil)
            deleteAlertController.setupBasicTint()
            
            ///add deleteAlertAction
            deleteAlertController.addAction(deleteAlertAction)
            
            ///add cancelAlertAction
            deleteAlertController.addAction(cancelAlertAction)
            
            ///Present deleteAlertController
            self.present(deleteAlertController, animated: true)
        }
    }
    
    internal func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        ///Setup actions
        let done = setupDoneAction(indexPath: indexPath)
        let share = setupShareAction(indexPath: indexPath)
        
        ///Setup all swipe actions
        return UISwipeActionsConfiguration(actions: [share, done])
    }
}

