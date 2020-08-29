//
//  RemindersViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 31.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift
import SPStorkController
import SPAlert

//MARK: - RemindersViewController main class
final class RemindersViewController: BasicViewController {
    
    //MARK: Keys
    enum Keys: String {
        case remindersSaveKey                = "RemindersSaveKey"
        case remindersDatesSaveKey           = "RemindersDatesSaveKey"
        case remindersCompletedSaveKey       = "remindersCompletedSaveKey"
        case remindersCompletedDatesSaveKey  = "remindersCompletedDatesSaveKey"
        
        
        //MARK: NotificationNames
        enum NotificationNames: String {
            case deleteNotificationName   = "DeleteNotificationName"
            case doneNotificationName     = "DoneNotificationName"
        }
    }
    
    ///Presenter
    var presenter: RemindersViewControllerPresenterProtocol {
        return RemindersViewControllerPresenter(sections: sections)
    }
    
    ///Sections
    let sections: [RemindersMenuSectionType] = [.reminders, .completed]

    
    //MARK: @IBOutlets
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var editorControlsBackView: UIView!
    @IBOutlet weak var remindersMenuTableView: UITableView!
    
    
    //MARK: Private, Lazy Properties
    //UIRefreshControl
    private lazy var menuRefreshControl: UIRefreshControl = {
        let refreshControl = BasicRefreshControl()
        return refreshControl
    }()
    
    //BasicSearchController
    private lazy var searchController = BasicSearchController()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var searchedArticle = [String]()
    var isSearching: Bool = false
    
    //MARK: Public
    ///Deleted Indexes
    public var deletedIndex: Int?
    public var deletedIndexPath: IndexPath?
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setup Content
        presenter.setupSavedRemindersArrays(remindersSaveKey: Keys.remindersSaveKey.rawValue, remindersDatesSaveKey: Keys.remindersDatesSaveKey.rawValue, remindersCompletedDatesSaveKey: Keys.remindersCompletedDatesSaveKey.rawValue, remindersCompletedSaveKey: Keys.remindersCompletedSaveKey.rawValue)
        
        ///Setup UI
        setupBasicViewControllerUI()
        
        ///Add Observaers
        NotificationCenter.default.addObserver(self, selector: #selector(deleteReminderAction(notification: )), name: Notification.Name(rawValue: Keys.NotificationNames.deleteNotificationName.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(doneReminder(notification: )), name: Notification.Name(rawValue: Keys.NotificationNames.doneNotificationName.rawValue), object: nil)
    }
    
    
    //MARK: BasicViewControllerProtocol method
    internal func setupBasicViewControllerUI() {
        
        ///Set view backColor
        view.backgroundColor = UIColor.TableViewColors.tableViewBackgroundColor
        
        ///Setup UI
        setupInputTextField()
        setupTableView()
        setupNavController()
        setupAddButton()
        setupRefreshControl()
        setupSearchBar()
    }
}



//MARK: - RemindersViewController main methos and functions extension
extension RemindersViewController {
    
    //MARK: @objc
    @objc func deleteReminderAction(notification: Notification.Name) {
        let semaphore = DispatchSemaphore(value: 1)
        let mainQueue = DispatchQueue.main
        
        guard let deletedIndex = self.deletedIndex else { return }
        guard let deletedIndexPath = self.deletedIndexPath else { return }
        
        mainQueue.async {
            semaphore.wait() //-1
            
            ///reload remindersMenuTableView data
            self.remindersMenuTableView.reloadData()
            
            semaphore.signal() //+1
        }
        
        mainQueue.async {
            semaphore.wait() //-1
            
            ///Remove from array
            reminders.remove(at: deletedIndex)
            dates.remove(at: deletedIndex)
            
            semaphore.signal() //+1
        }
        
        mainQueue.async {
            semaphore.wait() //-1
            
            ///Remove from remindersMenuTableView
            self.remindersMenuTableView.beginUpdates()
            self.remindersMenuTableView.deleteRows(at: [deletedIndexPath], with: .right)
            self.remindersMenuTableView.endUpdates()
            
            semaphore.signal() //+1
        }
        
        mainQueue.async {
            semaphore.wait() //-1
            
            self.presenter.saveReminders()
            
            semaphore.signal() //+1
        }
    }
    
    @objc func doneReminder(notification: Notification.Name) {
        let semaphore = DispatchSemaphore(value: 1)
        let mainQueue = DispatchQueue.main
        
        guard let deletedIndex = self.deletedIndex else { return }
        guard let deletedIndexPath = self.deletedIndexPath else { return }
        
        mainQueue.async {
            semaphore.wait() //-1
            
            ///reload remindersMenuTableView data
            self.remindersMenuTableView.reloadData()
            
            semaphore.signal() //+1
        }
        
        mainQueue.async {
            semaphore.wait() //-1
            
            completedReminders.append(reminders[deletedIndex])
            completedDates.append(dates[deletedIndex])
            
            ///Save arrays
            self.presenter.saveReminders()
            
            ///Insert new row
            let indexPath = IndexPath(row: completedReminders.count - 1, section: 1)
            
            self.remindersMenuTableView.beginUpdates()
            self.remindersMenuTableView.insertRows(at: [indexPath], with: .bottom)
            self.remindersMenuTableView.endUpdates()
            
            ///Remove from array
            reminders.remove(at: deletedIndex)
            dates.remove(at: deletedIndex)
            
            semaphore.signal() //+1
        }
        
        mainQueue.async {
            semaphore.wait() //-1
            
            ///Remove from remindersMenuTableView
            self.remindersMenuTableView.beginUpdates()
            self.remindersMenuTableView.deleteRows(at: [deletedIndexPath], with: .right)
            self.remindersMenuTableView.endUpdates()
            
            semaphore.signal() //+1
        }
        
        mainQueue.async {
            semaphore.wait()
            
            let alertTitle = "Completed"
            let alertMessage = "The Reminder has been completed"
            let alertView = SPAlertView(title: alertTitle, message: alertMessage, preset: SPAlertPreset.done)
            alertView.duration = 2
            alertView.present()
            
            semaphore.signal()
        }
        
        mainQueue.async {
            semaphore.wait() //-1
            
            ///Save arrays
            self.presenter.saveReminders()
            
            semaphore.signal() //+1
        }
    }
    
    
    //MARK: Private
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        setupSearchBar(searchController.searchBar)
    }
    
    private func setupNavController() {
        guard let navBar = navigationController?.navigationBar else { return }
        
        ///Setup StatusBar
        if DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_7 || DeviceType.IS_IPHONE_7P || DeviceType.IS_IPAD {
            setupStatusBarView(with: 20)
        } else {
            setupStatusBarView(with: 50)
        }
        
        ///Set Bar backgroundColor
        let color = UIColor.systemBackground
        navBar.barTintColor = color
        navBar.backgroundColor = color
        navBar.tintColor = BasicProperties.color
        
        ///Set title
        title = "Reminders"
    }
    
    private func setupTableView() {
        
        ///Setup tableFooterView
        let footerView = UIView(frame: CGRect.zero)
        remindersMenuTableView.tableFooterView = footerView
        remindersMenuTableView.delegate = self
        remindersMenuTableView.dataSource = self
        remindersMenuTableView.separatorStyle = .singleLine
        remindersMenuTableView.separatorColor = .clear
        remindersMenuTableView.setupBasicEditorTableView()
        remindersMenuTableView.backgroundColor = .clear
    }
    
    private func setupInputTextField() {
        let placeholder = "Enter here your reminder"
        inputTextField.placeholder = placeholder
        inputTextField.tintColor = BasicProperties.color
    }
    
    private func setupRefreshControl() {
        remindersMenuTableView.refreshControl = menuRefreshControl
        menuRefreshControl.addTarget(self, action: #selector(setupRefreshControlAction), for: .valueChanged)
    }
    
    private func setupAddButton() {
        let font = UIFont.systemFont(ofSize: 14.5, weight: .bold)
        let cornerRadius = addButton.frame.height / 2
        addButton.layer.cornerRadius = cornerRadius
        addButton.backgroundColor = BasicProperties.color
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitle("ADD", for: .normal)
        addButton.titleLabel?.font = font
        addButton.buttonsShadows()
        addButton.titleLabel?.labelShadow()
    }
    
    private func setupStatusBarView(with size: CGFloat) {
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: size))
        statusBarView.backgroundColor = .systemBackground
        navigationController?.view.addSubview(statusBarView)
    }
    
    private func setupSearchBar(_ searchBar: UISearchBar) {
        let searchField = searchBar.value(forKey: "searchField") as? UITextField

        if let field = searchField {
            field.setupBasicSearchBar()
        }
    }
    
    
    //MARK: Internal
    internal func setupBackImageView(backImageView: UIImageView, section: Int) {
        let section = sections[section]
        
        backImageView.layer.cornerRadius = BasicProperties.cornerRadius
        
        switch section {
        case .reminders:
            backImageView.image = #imageLiteral(resourceName: "Снимок экрана 2020-07-29 в 16.20.16")
        case .completed:
            backImageView.image = #imageLiteral(resourceName: "Снимок экрана 2020-07-29 в 16.10.25")
        }
    }
    
    internal func setupTitleLabel(title: UILabel) {
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    internal func setupSubtitleLabel(subtitle: UILabel) {
        subtitle.labelShadow()
        subtitle.layer.shadowColor = subtitle.textColor!.cgColor
        subtitle.textColor = #colorLiteral(red: 0.8760064758, green: 0.8760064758, blue: 0.8760064758, alpha: 1)
    }
    
    internal func setupReminderViewContentBack(contentBack: UIView, section: Int) {
        let section = sections[section]
        
        contentBack.viewShadows()
        contentBack.layer.shadowRadius = 5
        contentBack.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentBack.layer.cornerRadius = BasicProperties.cornerRadius
        
        switch section {
        case .reminders:
            contentBack.backgroundColor = BasicProperties.color
            contentBack.layer.shadowColor = contentBack.backgroundColor?.cgColor
        case .completed:
            let contentColor = #colorLiteral(red: 0.1460161237, green: 0.5163441999, blue: 1, alpha: 1)
            contentBack.backgroundColor = contentColor
            contentBack.layer.shadowColor = contentColor.cgColor
        }
    }
    
    internal func setupRemindersContent(cell: RemindersTableViewCell, row: Int, section: Int) {
        if isSearching {
            cell.subtitleLabel.text = ""
            cell.titleLabel.text = searchedArticle[row]
        } else {
            cell.titleLabel.text = presenter.setupRemindersContent(row: row, section: section)
            cell.subtitleLabel.text = presenter.setupRemindersDatesContent(row: row, section: section)
        }
    }
    
    
    //MARK: Public
    public func reloadTable() {
        remindersMenuTableView.reloadData()
    }
    
    public func shareAction(at indexPath: IndexPath, for vc: UIViewController) -> UIContextualAction {
        let title = "Share"
        let action = UIContextualAction(style: .normal, title: title) { (action, view, completion) in
            
            ///Present ActivityVC
            ActivityVCManeger.showBasic(content: self.presenter.shareContent(at: indexPath), for: self)
        }
        
        ///Setup action style
        let backColor = UIColor.systemTeal
        let imageName = "square.and.arrow.up"
        let image = UIImage(systemName: imageName)
        
        action.backgroundColor = backColor
        action.image = image
            
        return action
    }
}
