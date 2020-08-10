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
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSwitch()
        setupNotificationsLabel()
        setupTitle()
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
            notificationsOnLabel.text = "Notifications On"
        } else {
            notificationsOnLabel.text = "Notifications Off"
        }
        notificationsOnLabel.textColor = .black
        notificationsOnLabel.backgroundColor = .clear
    }
    
    private func setupSwitch() {
        notificationsOnSwitch.isOn = NotificationsSettings.shared.notificationsOn
        notificationsOnSwitch.onTintColor = BasicProperties.color
    }
    
    private func setupTitle() {
        title = "Articles Notifications"
    }
}
