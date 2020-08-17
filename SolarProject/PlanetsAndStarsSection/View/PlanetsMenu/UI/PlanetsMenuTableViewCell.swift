//
//  PlanetsMenuTableViewCell.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import SPAlert

//MARK: - PlanetsMenuTableViewCell
final class PlanetsMenuTableViewCell: UITableViewCell {
    
    ///Root VC
    var rootVC: UIViewController?
    
    //MARK: PlanetsMenuTableViewCellPresenter
    private var presenter: PlanetsMenuTableViewCellPresenterProtocol {
        return PlanetsMenuTableViewCellPresenter()
    }
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var contentTextViewBackground: UIView!
    
    
    //MARK: Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupRootVC()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupRootVC()
    }
}



//MARK: - @IBActions
extension PlanetsMenuTableViewCell {
    @IBAction func setNotificationOnArticle(sender: UIButton) {
        presentNotificationAlert()
    }
    
    @IBAction func putInReminder(_ sender: UIButton) {
        presenter.addReminder(title: titleLabel.text!)
        setupRemindersAlert()
        reminderButton.flash()
    }
}



//MARK: - Main Methods
extension PlanetsMenuTableViewCell {
    
    //MARK: Setup Root VC
    private func setupRootVC() {
        rootVC = UIApplication.shared.keyWindow?.rootViewController!
    }


    //MARK: Setup Notification Action methods(Private)
    private func presentNotificationAlert() {
        
        ///Present alertController
        if NotificationsSettings.shared.notificationsOn {
            rootVC?.present(setupAlertController(), animated: true, completion: nil)
        } else {
            setupNotificationsOffAlert()
        }
    }
    
    private func setupAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: "\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        ///Setup DatePicker
        let datePicker: UIDatePicker? = UIDatePicker()
        datePicker?.timeZone = NSTimeZone.local
        datePicker?.frame = CGRect(x: 0, y: 15, width: 270, height: 60)
        
        ///Setup UIAlertActions
        let setNotificationAction = UIAlertAction(title: "Done", style: .default, handler: { [self] (_) in
            PushNotifications.setupBasicNotification(body: self.titleLabel.text!, date: datePicker!.date)
            self.notificationButton.pulsate()
            notificationButton.addNotificationButtonPulse(view: notificationButton!)
            self.setupNotificationAlert()
            NotificationsSettings.shared.setupAudio()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ///Setup alertController
        alertController.addAction(cancelAction)
        alertController.addAction(setNotificationAction)
        alertController.view.addSubview(datePicker!)
        alertController.view.tintColor = BasicProperties.color
        return alertController
    }
    
    private func setupNotificationsOffAlert() {
        FastAlert.showBasic(title: "Notifications disabled.", message: "If you want to enable notifications go to settings.", vc: rootVC!)
    }
    
    private func setupNotificationAlert() {
        let alertView = SPAlertView(title: "Notification was set", message: "Notification on \(titleLabel.text!) article was set on \(LocalizedDate("us", datePosix: "MMMM d  'at'  h:mm a").returnDate())", preset: SPAlertPreset.done)
        alertView.duration = 2
        alertView.present()
    }
    
    
    //MARK: Setup Reminders Action methods
    private func setupRemindersAlert() {
        let alertView = SPAlertView(title: "Added to Reminders", message: "\(titleLabel.text!) article was added to Reminders on \(LocalizedDate("us", datePosix: "MMMM d  'at'  h:mm a").returnDate())", image: UIImage(systemName: "list.dash")!)
        alertView.duration = 2
        alertView.present()
    }
}
