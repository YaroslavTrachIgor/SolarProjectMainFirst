//
//  SupportViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 10.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

//MARK: - SupportViewController main class
final class SupportViewController: BasicViewController {
    
    //MARK: @IBOutlets
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var contactWithMessagesButton: UIButton!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setup UI
        setupBasicViewControllerUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setupAnimation()
    }
    
    
    //MARK: BasicViewController method
    internal func setupBasicViewControllerUI() {
        
        ///Setup Contrels
        setupContactButton()
        setupContactWithMessagesButton()
        setupNavConroller()
        
        ///Setup View
        view.backgroundColor = .systemBackground
    }
}



//MARK: - SupportViewController Main Methods
extension SupportViewController {
    
    //MARK: Private
    private func setupAnimation() {
        let buttons = [contactButton, contactWithMessagesButton]
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            for button in buttons {
                button?.alpha = 1
            }
        }, completion: nil)
    }
    
    private func setupNavConroller() {
        title = "Support"
    }
    
    private func setupContactButton() {
        contactButton.setTitleColor(BasicProperties.color, for: .normal)
        contactButton.layer.borderColor = BasicProperties.color.cgColor
        contactButton.layer.borderWidth = 1.6
        contactButton.layer.cornerRadius = BasicProperties.cornerRadius
        contactButton.backgroundColor = .clear
        contactButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.6, weight: .medium)
        contactButton.buttonsShadows()
        contactButton.alpha = 0
    }
    
    private func setupContactWithMessagesButton() {
        contactWithMessagesButton.buttonsShadows()
        contactWithMessagesButton.layer.shadowColor = BasicProperties.color.cgColor
        contactWithMessagesButton.layer.cornerRadius = BasicProperties.cornerRadius
        contactWithMessagesButton.backgroundColor = BasicProperties.color
        contactWithMessagesButton.setTitle("Contact with Messages", for: .normal)
        contactWithMessagesButton.setTitleColor(UIColor.white, for: .normal)
        contactWithMessagesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        contactWithMessagesButton.titleLabel?.labelShadow()
        contactWithMessagesButton.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        contactWithMessagesButton.alpha = 0
    }
}


//MARK: - @IBActions
extension SupportViewController {
    @IBAction func contactWithEmail(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setupBasicMailComposer()
        present(composer, animated: true)
    }
    
    @IBAction func contactWithMessages(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        composeVC.setupBasicMessageComposer()
        present(composeVC, animated: true)
    }
}



//MARK: - MFMessageComposeViewControllerDelegate extension
extension SupportViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            dismiss(animated: true, completion: nil)
        case .sent:
            dismiss(animated: true, completion: nil)
        case .failed:
            dismiss(animated: true, completion: nil)
        @unknown default:
            break
        }
    }
}



//MARK: - MFMailComposeViewControllerDelegate extension
extension SupportViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true)
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .saved:
            print("email was saved")
        case .sent:
            print("Email has been sent")
        case .failed:
            print("Failed Email sending")
        @unknown default:
            print("Fatal Error. SOS !!!")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
