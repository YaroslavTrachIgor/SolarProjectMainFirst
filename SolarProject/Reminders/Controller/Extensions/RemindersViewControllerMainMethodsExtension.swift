//
//  RemindersViewControllerProtocolExtension.swift
//  SolarProject
//
//  Created by Yaroslav on 03.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
import NotificationBannerSwift

//MARK: - RemindersViewController main methods extension
extension RemindersViewController {
    
    //MARK: Setup UI
    //MARK: Internal
    internal func setupDesignViews(cell: RemindersTableViewCell) {
        for view in cell.designViews {
            
            ///Set backgroundColor
            view.backgroundColor = BasicProperties.color
        }
    }
    
    internal func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        setupSearchBar(searchController.searchBar)
    }
    
    internal func setupNavController() {
        guard let navBar = navigationController?.navigationBar else { return }
        
        ///Setup StatusBar
        if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_7 || DeviceType.IS_IPHONE_7P || DeviceType.IS_IPAD {
            setupStatusBarView(with: 20)
        } else {
            setupStatusBarView(with: 50)
        }
        
        ///Set tint
        navBar.tintColor = BasicProperties.color
        
        ///Set Bar backgroundColor
        let color = UIColor.white
        navBar.barTintColor = color
        navBar.backgroundColor = color
        
        ///Setup shadow
        navBar.setupBasicShadow(color: #colorLiteral(red: 0.9680271373, green: 0.9680271373, blue: 0.9680271373, alpha: 1))
        
        ///Set title
        title = "REMINDERS"
    }
    
    internal func setupTableView() {
        
        ///Setup tableFooterView
        let footerView = UIView(frame: CGRect.zero)
        remindersMenuTableView.tableFooterView = footerView
        
        ///Set delegate and dataSource
        remindersMenuTableView.delegate = self
        remindersMenuTableView.dataSource = self
        
        ///Setup separator
        remindersMenuTableView.separatorStyle = .singleLine
        remindersMenuTableView.separatorColor = #colorLiteral(red: 0.948898427, green: 0.948898427, blue: 0.948898427, alpha: 1)
        
        ///Set keyboard dissmis mode
        remindersMenuTableView.setupBasicEditorTableView()
        
        ///Set backgroundColor
        remindersMenuTableView.backgroundColor = .white
    }
    
    internal func setupInputTextField() {
        
        ///Setup placeholder
        inputTextField.placeholder = "Enter here your reminder"
        
        ///Set tint
        inputTextField.tintColor = BasicProperties.color
        
        ///Setup Shadow
        inputTextFielBack.layer.shadowOffset = CGSize(width: 0, height: 3)
        inputTextFielBack.layer.shadowRadius = BasicProperties.cornerRadius
        
        ///Set shadow for inputTextField
        inputTextField.viewShadows()
        inputTextField.layer.shadowColor = #colorLiteral(red: 0.9813625978, green: 0.9813625978, blue: 0.9813625978, alpha: 1)
        inputTextField.layer.shadowRadius = 40
    }
    
    internal func setupRefreshControl() {
        
        ///Setup refreshControl
        remindersMenuTableView.refreshControl = menuRefreshControl
        
        ///Add Action
        menuRefreshControl.addTarget(self, action: #selector(setupRefreshControlAction), for: .valueChanged)
    }
    
    internal func setupAddButton() {
        
        ///Setup corners
        addButton.layer.cornerRadius = BasicProperties.cornerRadius
        
        ///Setup Shadow
        addButton.viewShadows()
        
        ///Set backgroundColor
        addButton.backgroundColor = .white
        
        ///Set Title Color
        addButton.setTitleColor(BasicProperties.color, for: .normal)
        
        ///Set Title shadow
        addButton.titleLabel?.labelShadow()
        addButton.titleLabel?.layer.shadowColor = BasicProperties.color.cgColor
    }
    
    internal func setupAddBunner() {
        bunnerView.adUnitID = "ca-app-pub-8702634561077907/5121256822"
        bunnerView.rootViewController = self
        bunnerView.load(GADRequest())
    }

    internal func setupStatusBarView(with size: CGFloat) {
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: size))
        statusBarView.backgroundColor = .white
        navigationController?.view.addSubview(statusBarView)
    }
    
    internal func setupShareAction(indexPath: IndexPath) -> UIContextualAction {
        let share = UIContextualAction(style: .normal, title: "Share") { [self] (action, view, completion) in
            
            ///Present ActivityVC
            ActivityVCManeger.showBasic(content: presenter.setupShareContent(indexPath: indexPath), for: self)
        }
        
        ///Setup action style
        let backColor = UIColor.systemTeal
        let image = UIImage(systemName: "square.and.arrow.up")
        
        share.backgroundColor = backColor
        share.image = image
        
        return share
    }
    
    internal func setupDoneAction(indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            
            ///Setup Semaphore
            let semaphore = DispatchSemaphore(value: 1)
            let mainQueue = DispatchQueue.main
            
            mainQueue.async {
                semaphore.wait() //-1
                
                self.presenter.doneAction(at: indexPath)
                
                semaphore.signal() //+1
            }
            
            mainQueue.async {
                semaphore.wait() //-1
                
                ///reload remindersMenuTableView data
                self.remindersMenuTableView.reloadData()
                
                ///Remove from remindersMenuTableView
                self.remindersMenuTableView.beginUpdates()
                self.remindersMenuTableView.deleteRows(at: [indexPath], with: .right)
                self.remindersMenuTableView.endUpdates()
                
                semaphore.signal() //+1
            }
            
            mainQueue.async {
                semaphore.wait() //-1
            
                ///Setup doneBunner
                let doneBunner = StatusBarNotificationBanner(
                    title: "THE  REMINDER  HAS  BEEN  COMPLETED",
                    style: .info,
                    colors: nil)
                
                ///Setup doneBunner properties
                doneBunner.dismissOnTap = true
                doneBunner.autoDismiss = true
                
                ///Show Banner
                doneBunner.show()
            
                semaphore.signal() //+1
            }
        }
        
        ///Setup action style
        let backColor = UIColor.systemBlue
        let image = UIImage(systemName: "checkmark.circle")
        
        action.backgroundColor = backColor
        action.image = image
        
        return action
    }
    
    
    internal func insertNewCell() {
        if !inputTextField.text!.isEmpty {
            presenter.inhertRow(text: inputTextField.text!, method: {
                reloadTable()
            })
            
            ///Setup Semaphore
            let semaphore = DispatchSemaphore(value: 1)
            let mainQueue = DispatchQueue.main
            
            mainQueue.async {
                semaphore.wait() //-1
                
                ///Insert new row
                let indexPath = IndexPath(row: reminders.count - 1, section: 0)
                
                self.remindersMenuTableView.beginUpdates()
                self.remindersMenuTableView.insertRows(at: [indexPath], with: .bottom)
                self.remindersMenuTableView.endUpdates()
                
                semaphore.signal() //+1
            }
            
            mainQueue.async {
                semaphore.wait() //-1
                
                ///Clear textField and UIView
                self.inputTextField.text = ""
                self.view.endEditing(true)
                
                semaphore.signal() //+1
            }
        }
    }
    
    internal func reloadTable() {
        remindersMenuTableView.reloadData()
    }
    
    internal func setupSearchBar(_ searchBar: UISearchBar) {
        let searchField = searchBar.value(forKey: "searchField") as? UITextField

        if let field = searchField {
            field.setupBasicSearchBar()
        }
    }
}
