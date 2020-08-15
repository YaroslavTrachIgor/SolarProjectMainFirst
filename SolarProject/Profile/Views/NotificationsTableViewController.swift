//
//  NotificationsTableViewController.swift
//  SolarProject
//
//  Created by Yaroslav on 06.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit

//MARK: - NotificationsTableViewController Main class
final class NotificationsTableViewController: UITableViewController {

    //MARK: @IBOutlets
    @IBOutlet weak var notificationsOnLabel: UILabel!
    @IBOutlet weak var notificationsOnSwitch: UISwitch!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messagePickerView: UIPickerView!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSwitch()
        setupNotificationsLabel()
        setupTitle()
        setupMessagePickerView()
        setupMessageLabel()
    }
}



//MARK: - @IBActions
extension NotificationsTableViewController {
    @IBAction func notificationsOn(_ sender: UISwitch) {
        let semaphore = DispatchSemaphore(value: 1)
        let mainQueue = DispatchQueue.main
        
        mainQueue.async {
            semaphore.wait()
            
            NotificationsSettings.shared.notificationsOn = sender.isOn
            
            semaphore.signal()
        }
        
        mainQueue.async {
            semaphore.wait()
            
            if sender.isOn {
                self.notificationsOnLabel.setupContentWithAnimation(text: "Notifications enabled")
            } else {
                self.notificationsOnLabel.setupContentWithAnimation(text: "Notifications disabled")
            }
            
            semaphore.signal()
        }
        
        mainQueue.async {
            semaphore.wait()
            
            defaults.set(NotificationsSettings.shared.notificationsOn, forKey: "NotificationsOnKey")
            
            semaphore.signal()
        }
    }
}



//MARK: - Main methods
extension NotificationsTableViewController {
    private func setupNotificationsLabel() {
        if NotificationsSettings.shared.notificationsOn {
            notificationsOnLabel.text = "Notifications enabled"
        } else {
            notificationsOnLabel.text = "Notifications disabled"
        }
        notificationsOnLabel.textColor = .black
        notificationsOnLabel.backgroundColor = .clear
    }
    
    private func setupSwitch() {
        notificationsOnSwitch.isOn = NotificationsSettings.shared.notificationsOn
        notificationsOnSwitch.onTintColor = BasicProperties.color
    }
    
    private func setupMessagePickerView() {
        messagePickerView.delegate = self
        messagePickerView.dataSource = self
    }
    
    private func setupMessageLabel() {
        messageLabel.text = NotificationsSettings.shared.notificationsBody
        messageLabel.textColor = .black
        messageLabel.backgroundColor = .clear
    }
    
    private func setupTitle() {
        title = "Articles Notifications"
    }
}



//MARK: - UIPickerViewDataSource & UIPickerViewDelegate extension
extension NotificationsTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PushNotifications.PushNotificationsBasicWords.headers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        messageLabel.text = "Message: " + PushNotifications.PushNotificationsBasicWords.headers[row] + "..."
        NotificationsSettings.shared.notificationsBody = messageLabel.text!
        defaults.setValue(NotificationsSettings.shared.notificationsBody, forKey: "NotificationMessageKey")
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var titleLabel: UILabel
        
        ///Check the view
        if let view = view as? UILabel {
            titleLabel = view
        } else {
            titleLabel = UILabel()
        }
        
        ///Setup titleLabel
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.text = PushNotifications.PushNotificationsBasicWords.headers[row] + "..."
        
        return titleLabel
    }
}
