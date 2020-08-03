//
//  RemindersVCIBActions.swift
//  SolarProject
//
//  Created by Yaroslav on 27.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import SPAlert

//MARK: - @objc's and @IBActions
extension RemindersViewController {
    @objc func setupRefreshControlAction() {
        reloadTable()
    }
       
    @IBAction func insertNewReminder(_ sender: Any) {
        if !inputTextField.text!.isEmpty || !(inputTextField.text == "") {
            
            ///Setup Semaphore
            let semaphore = DispatchSemaphore(value: 1)
            let mainQueue = DispatchQueue.main
            
            mainQueue.async {
                semaphore.wait() //-1
                
                self.presenter.inhertRow(method: {
                    self.reloadTable()
                }, text: self.inputTextField.text)
                
                semaphore.signal() //+1
            }
            
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
            
            mainQueue.async {
                semaphore.wait() //-1
                
                ///Setup and present SPAlertView
                let alertView = SPAlertView(title: "Added new Reminder", message: "Added new Reminder on \(LocalizedDate("us", datePosix: "MMMM d  'at'  h:mm a").returnDate())", preset: .add)
                alertView.duration = 2
                alertView.present()
                
                semaphore.signal() //+1
            }
            
            mainQueue.async {
                semaphore.wait() //-1
                
                self.inputTextField.rightView = nil
                self.inputTextField.rightViewMode = .never
                
                semaphore.signal() //+1
            }
        } else {
            
            ///Setup ErrorImageView for inputTextField
            let errorImageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 30, height: 20))
            errorImageView.image = UIImage(systemName: "exclamationmark.triangle")
            errorImageView.contentMode = .scaleAspectFit
            
            ///Set ErrorImageView as rightView
            self.inputTextField.rightView = errorImageView
            self.inputTextField.rightViewMode = .always
            
            ///Hide errorImageView with animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                UIView.transition(with: errorImageView,
                     duration: 0.25,
                      options: .transitionCrossDissolve,
                   animations: {
                    errorImageView.isHidden = true
                }, completion: nil)
            })
            return
        }
    }
}
