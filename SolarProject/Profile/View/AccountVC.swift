//
//  AccountVC.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 03.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import Parse
import GoogleSignIn
import SPAlert

//MARK: - AccountVCProtocol
protocol AccountVCProtocol {
    
    ///For viewDidLoad
    func setupUserPersonalInfo()
    
    ///Setup Google SignIn delegate
    func setupGSignInDelegate()
    
    ///For sharing action
    func setupShareTextFieldsContent() -> String
    
    ///Setup Save function
    func saveUsername(user: PFUser)
    func savePassword(textField: UITextField, user: PFUser)
    func saveEmail(textField: UITextField, user: PFUser)
    func signUpSetup(user: PFUser)
}



//MARK: - AccountVC main class
final class AccountVC: UITableViewController {
    
    //MARK: User Photo
    public var userPhoto = UIImage()
    
    //UIImagePickerController
    let imagePicker = UIImagePickerController()
    
    
    //MARK: UserDefaults
    public let defaults = UserDefaults.standard
    
    
    //MARK: Keys
    struct Keys {
        static let firstNameKey  = "firstNameKey"
        static let familyNameKey = "familyNameKey"
        static let emailKey      = "emailKey"
        static let phoneKey      = "phoneKey"
        static let userPhotoKey  = "userPhotoKey"
        static let passwordKey   = "passwordKey"
    }
    
    ///Completion
    var completion: ((String, String, String) -> ())?
    
    //MARK: @IBOutlets
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var setPhotoButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    @IBOutlet weak var firstNamePlaceholderLabel: PlaceholderLabel!
    @IBOutlet weak var surNamePlaceholderLabel: PlaceholderLabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var googlePreviewButton: UIButton!
    @IBOutlet weak var googleImageView: UIImageView!
    
    
    //MARK: @IBOutlet collections
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var placeholderLabels: [PlaceholderLabel]!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setup User Personal Info
        setupUserPersonalInfo()
        setupUserImageView()
        setupPhotoButton()
        setupTableView()
        setupTitle()
        setupGoogleSignInPresentingController()
        setupGSignInDelegate()
        setupSignInButton()
        setupGooglePreviewButton()
        setupTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            let fullName = firstNameTextField.text! + " " + surNameTextField.text!
            let email = defaults.value(forKey: AccountVC.Keys.emailKey) as? String ?? "Email:"
            let phone = defaults.value(forKey: AccountVC.Keys.phoneKey) as? String ?? "Phone:"
            completion!(fullName, email, phone)
        }
    }
}



//MARK: - AccountVCProtocol extension
extension AccountVC: AccountVCProtocol {
    
    //MARK: Setup GSignIn Delegate
    internal func setupGSignInDelegate() {
        GIDSignIn.sharedInstance().delegate = self
    }
    

    //MARK: Setup Save function
    internal func saveUsername(user: PFUser) {
        let firstName = self.firstNameTextField.text!
        let surname = self.surNameTextField.text!
        let username = firstName + surname
        
        ///Check username
        if username.isValidFullName() && username.count > 3 && !(username.isEmpty) {
            user.username = username
            
            self.firstNamePlaceholderLabel.text = "FIRST NAME"
            self.surNamePlaceholderLabel.text = "SURNAME"
            
            for placeholderLabel in self.placeholderLabels {
                placeholderLabel.textColor = .separator
            }
        } else {
            let usernamePlaceholderLabels = [self.firstNamePlaceholderLabel, self.surNamePlaceholderLabel]
            for placeholderLabel in usernamePlaceholderLabels {
                placeholderLabel!.text = "INCORRECT FIRST NAME OR FAMILY NAME"
                placeholderLabel!.textColor = .red
            }
        }
    }
    
    internal func savePassword(textField: UITextField, user: PFUser) {
        
        ///Check PASSWORD
        if textField.tag == 4 {
            if textField.text!.count < 8 {
                for placeholderLabel in self.placeholderLabels {
                    if placeholderLabel.tag == 3 {
                        placeholderLabel.text = "INCORRECT PASSWORD. Password must be at least 8 characters"
                        placeholderLabel.textColor = .red
                    }
                }
            } else {
                user.password = textField.text
                
                for placeholderLabel in self.placeholderLabels {
                    if placeholderLabel.tag == 3 {
                        placeholderLabel.text = "CREATE PASSWORD"
                        placeholderLabel.textColor = .separator
                    }
                }
            }
        }
    }
    
    internal func saveEmail(textField: UITextField, user: PFUser) {
        
        ///Check Email
        if textField.tag == 2 {
            if (textField.text?.isValidEmail())! {
                user.email = textField.text
            } else {
                FastAlert.showBasic(
                    title: "Incorrect Email",
                    message: "Please, check your email. Your mail may already be on the server or you have incorrectly recorded it.",
                    vc: self
                )
            }
        }
    }
    
    internal func signUpSetup(user: PFUser) {
        user.signUpInBackground { (success, error) -> Void in
            if let error = error as NSError? {
                let alertView = SPAlertView(
                    title: "Error",
                    message: "\(error)",
                    preset: .error)
                alertView.duration = 2
                alertView.present()
            } else {
                let alertView = SPAlertView(
                    title: "Profile has been saved",
                    message: nil,
                    preset: .done)
                alertView.duration = 2
                alertView.present()
                
                let infoAboutProfile = "Thank you for filling out information about yourself. You help us learn more about our users. The information that you have filled out here will not be terminated under any circumstances. Also now you can always be notified of the latest news and problems in our application."
            }
        }
    }
    
    internal func setupUserPersonalInfo() {
        for textField in textFields {
            switch textField.tag {
            case 0:
                textField.text = defaults.value(forKey: Keys.firstNameKey) as? String
            case 1:
                textField.text = defaults.value(forKey: Keys.familyNameKey) as? String
            case 2:
                textField.text = defaults.value(forKey: Keys.emailKey) as? String
            case 3:
                textField.text = defaults.value(forKey: Keys.phoneKey) as? String
            case 4:
                textField.text = defaults.value(forKey: Keys.passwordKey) as? String
            default:
                return
            }
        }
    }
    
    internal func setupShareTextFieldsContent() -> String {
        for textField in textFields {
            return textField.text!
        }
        return ""
    }
}



//MARK: AccountVC UI Setup methods
extension AccountVC {
    
    //MARK: Setup UI
    private func setupTextFields() {
        for textField in textFields {
            textField.setupBasicAccountTextField()
        }
        
        surNameTextField.setupBasicAccountTextField()
        firstNameTextField.setupBasicAccountTextField()
    }
    
    private func setupGooglePreviewButton() {
        googlePreviewButton.setTitleColor(BasicProperties.color, for: .normal)
        googlePreviewButton.setTitle("Fill with Google", for: .normal)
        googlePreviewButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        googlePreviewButton.backgroundColor = .white
    }
    
    private func setupSignInButton() {
        signInButton.alpha = 0.017
    }
    
    private func setupGoogleSignInPresentingController() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    private func setupTitle() {
        title = "Personal Account"
    }
    
    private func setupPhotoButton() {
        setPhotoButton.setTitle("SET PHOTO", for: .normal)
        setPhotoButton.backgroundColor = .clear
        setPhotoButton.setTitleColor(BasicProperties.color, for: .normal)
        setPhotoButton.layer.cornerRadius = BasicProperties.cornerRadius
        setPhotoButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 10.9)
        setPhotoButton.layer.borderColor = BasicProperties.color.cgColor
        setPhotoButton.layer.borderWidth = 1.3
        setPhotoButton.buttonsShadows()
    }
    
    private func setupTableView() {
        tableView.setupBasicEditorTableView()
    }
    
    private func setupUserImageView() {
        
        ///Setup style
        userPhotoImageView.setupProfileImageView()
        
        ///Setup userPhoto
        let data = defaults.object(forKey: Keys.userPhotoKey) as! NSData?
        
        ///Check Image
        if data != nil {
            userPhotoImageView.image = UIImage(data: (data!) as Data)
        } else {
            userPhotoImageView.image = UIImage(systemName: "person.crop.circle")
        }
    }
}
