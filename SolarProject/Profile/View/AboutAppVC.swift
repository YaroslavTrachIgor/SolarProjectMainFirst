//
//  AboutAppVC.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - AboutAppVC protocol
protocol AboutAppVCProtocol {
    func setupContent()
    func setupTitle()
}



//MARK: - AboutAppVC main class
final class AboutAppVC: UIViewController {
    
    //MARK: @IBOutlets
    @IBOutlet weak var contentTextView: UITextView!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
        setupTitle()
    }
}



//MARK: - AboutAppVCProtocol extension
extension AboutAppVC: AboutAppVCProtocol {
    internal func setupContent() {
        contentTextView.text = AboutAppVCModel.aboutAppDescriptionContent
    }
    
    internal func setupTitle() {
        title = "About Application"
    }
}
