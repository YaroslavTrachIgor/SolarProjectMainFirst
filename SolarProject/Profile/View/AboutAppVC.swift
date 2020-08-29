//
//  AboutAppVC.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - AboutAppVC main class
final class AboutAppVC: BasicViewController {
    
    //MARK: @IBOutlets
    @IBOutlet weak var contentTextView: ContentTextView!
    @IBOutlet weak var sliderBack: ContentBack!
    @IBOutlet weak var slider: BasicFontChangeSlider!
    @IBOutlet weak var sliderBackShowerButton: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var contentBack: ContentBack!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setup UI
        setupBasicViewControllerUI()
    }
    
    
    //MARK: BasicViewController protocol
    internal func setupBasicViewControllerUI() {
        setupContent()
        setupTitle()
        setupSliderBack()
        setupSubtitleLabel()
        setupTitleLabel()
    }
}



//MARK: - @IBActions
extension AboutAppVC {
    @IBAction func share(_ sender: Any) {
        guard let content = contentTextView.text else { return }
        ActivityVCManeger.showBasic(content: content, for: self)
        UIApplication.setupBasicAppTint()
    }
    
    @IBAction func changeFont(_ sender: UISlider) {
        let fontSize = CGFloat(slider.value)
        var fontName = UIFont.systemFont(ofSize: fontSize, weight: .light)
        
        ///Set font with animation
        let animation = UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) {
            if sender.value > 15 {
                self.contentTextView.font = fontName
                
            } else if sender.value < 10 {
                fontName = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
                self.contentTextView.font = fontName
                
            } else {
                fontName = UIFont.systemFont(ofSize: fontSize, weight: .medium)
                self.contentTextView.font = fontName
            }
        }
        animation.startAnimation()
    }
    
    @IBAction func presentSliderBack(_ sender: Any) {
        sliderBackShowerButton.viewShowingWithAnimation(animating: sliderBack, main: self.view, nil)
    }
}



//MARK: - AboutAppVC Main Methods
extension AboutAppVC {
    private func setupContent() {
        contentTextView.text = AboutAppVCModel.aboutAppDescriptionContent
    }
    
    private func setupTitle() {
        title = "About Application"
    }
    
    private func setupSliderBack() {
        let transform = CGAffineTransform(scaleX: 0, y: 0)
        sliderBack.isHidden = true
        sliderBack.alpha = 0
        sliderBack.transform = transform
    }
    
    private func setupSubtitleLabel() {
        let subtitle = "Application Info".uppercased()
        let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        let textColor: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        subtitleLabel.textColor = textColor
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.alpha = 1
        subtitleLabel.text = subtitle
        subtitleLabel.font = font
    }
    
    private func setupTitleLabel() {
        let title = "Application Info"
        titleLabel.textColor = .label
        titleLabel.backgroundColor = .clear
        titleLabel.alpha = 1
        titleLabel.text = title
    }
}
