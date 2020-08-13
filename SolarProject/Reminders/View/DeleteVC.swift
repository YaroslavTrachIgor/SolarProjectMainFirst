//
//  DeleteVC.swift
//  SolarProject
//
//  Created by Yaroslav on 14.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import SPStorkController
import SPFakeBar

//MARK: - DeleteVC main class
final class DeleteVC: UIViewController {
    
    //MARK: Private
    private let navBar = SPFakeBarView(style: .stork)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: @IBOutlets
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupButtons()
    }
}



//MARK: - DeleteVC Main Methods
extension DeleteVC {
    
    //MARK: @objc
    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Private
    private func setupButtons() {
        setupDoneButton()
        setupDleteButton()
    }
    
    private func setupDoneButton() {
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "checkmark", withConfiguration: config)
        doneButton.setImage(image, for: .normal)
        doneButton.setTitleColor(BasicProperties.color, for: .normal)
        doneButton.layer.cornerRadius = 8
        doneButton.tintColor = BasicProperties.color
        doneButton.setTitleColor(BasicProperties.color, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    private func setupDleteButton() {
        deleteButton.tintColor = .white
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.layer.cornerRadius = 8
        deleteButton.backgroundColor = #colorLiteral(red: 0.9708763349, green: 0.2299415323, blue: 0.2072887329, alpha: 1)
    }
    
    private func setupNavBar() {
        navBar.titleLabel.text = "DELETION REMINDER"
        navBar.rightButton.setTitle("Cancel", for: .normal)
        navBar.rightButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        navBar.rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        navBar.rightButton.setTitleColor(.systemIndigo, for: .normal)
        view.addSubview(self.navBar)
    }
}



//MARK: - DeleteVC @IBActions
extension DeleteVC {
    @IBAction func deleteReminder(_ sender: Any) {
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "DeleteNotificationName"), object: nil)
        })
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "DoneNotificationName"), object: nil)
        })
    }
}
