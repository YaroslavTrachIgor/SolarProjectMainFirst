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
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var soundPickerView: UIPickerView!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSwitch()
        setupNotificationsLabel()
        setupTitle()
        setupMessagePickerView()
        setupMessageLabel()
        setupSoundPickerView()
        setupSoundLabel()
        setupTableView()
    }
}



//MARK: - @IBActions
extension NotificationsTableViewController {
    @IBAction func notificationsOn(_ sender: UISwitch) {
        DispatchQueue.main.async {
            NotificationsSettings.shared.notificationsOn = sender.isOn
        }
        defaults.set(NotificationsSettings.shared.notificationsOn, forKey: NotificationsSettings.NotificationsSettingsKeys.isOn.rawValue)
    }
}



//MARK: - Main methods
extension NotificationsTableViewController {
    private func setupNotificationsLabel() {
        notificationsOnLabel.setupBasicCellLabel(text: "Show Notifications")
    }
    
    private func setupSwitch() {
        notificationsOnSwitch.isOn = NotificationsSettings.shared.notificationsOn
        notificationsOnSwitch.onTintColor = BasicProperties.color
    }
    
    private func setupMessagePickerView() {
        messagePickerView.delegate = self
        messagePickerView.dataSource = self
        messagePickerView.tag = 1
    }
    
    private func setupMessageLabel() {
        messageLabel.setupBasicCellLabel(text: NotificationsSettings.shared.notificationsBody)
    }
    
    private func setupSoundPickerView() {
        soundPickerView.delegate = self
        soundPickerView.dataSource = self
        soundPickerView.tag = 0
    }
    
    private func setupSoundLabel() {
        soundLabel.setupBasicCellLabel(text: "Sound: " + NotificationsSettings.shared.notificationsSound!)
    }
    
    private func setupTitle() {
        title = "Articles Notifications"
    }
    
    private func setupTableView() {
        tableView.separatorColor = UIColor.TableViewColors.tableViewSeparatorColor
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemGroupedBackground
        tableView.isHidden = false
    }
}



//MARK: - UIPickerViewDataSource & UIPickerViewDelegate extension
extension NotificationsTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return PushNotifications.PushNotificationsBasicWords.soundNames.count
        case 1:
            return PushNotifications.PushNotificationsBasicWords.headers.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            soundLabel.text = "Sound: " + PushNotifications.PushNotificationsBasicWords.soundNames[row]
            NotificationsSettings.shared.notificationsSound = PushNotifications.PushNotificationsBasicWords.soundNames[row]
            defaults.setValue(NotificationsSettings.shared.notificationsSound, forKey: NotificationsSettings.NotificationsSettingsKeys.notificationsSound.rawValue)
            NotificationsSettings.shared.setupAudio()
        case 1:
            messageLabel.text = "Message: " + PushNotifications.PushNotificationsBasicWords.headers[row] + "..."
            NotificationsSettings.shared.notificationsBody = messageLabel.text!
            defaults.setValue(NotificationsSettings.shared.notificationsBody, forKey: NotificationsSettings.NotificationsSettingsKeys.notificationsBody.rawValue)
        default:
            break
        }
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
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textAlignment = .center
        
        ///Set content
        switch pickerView.tag {
        case 0:
            titleLabel.text = PushNotifications.PushNotificationsBasicWords.soundNames[row]
        case 1:
            titleLabel.text = PushNotifications.PushNotificationsBasicWords.headers[row] + "..."
        default:
            titleLabel.text = ""
        }
        
        return titleLabel
    }
}
