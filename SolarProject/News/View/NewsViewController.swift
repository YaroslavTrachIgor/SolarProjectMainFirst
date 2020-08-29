//
//  NewsViewController.swift
//  SolarProject
//
//  Created by Yaroslav on 30.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - NewsViewController main class
final class NewsViewController: BasicViewController {

    //MARK: Public
    public var mainTitle: String?
    public var date: String?
    public var content: String?
    public var image: UIImage?
    
    
    //MARK: @IBOutlets
    @IBOutlet weak var contentTextView: ContentTextView!
    @IBOutlet weak var contentBack: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sliderBack: ContentBack!
    @IBOutlet weak var slider: BasicFontChangeSlider!
    @IBOutlet weak var sliderBackShowerButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setup UI
        setupBasicViewControllerUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        setupBasicAnimation()
    }
    
    
    //MARK: BasicViewControllerProtocol func
    internal func setupBasicViewControllerUI() {
        setupContent()
        setupContentBack()
        setupContentTextView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupDateLabel()
        setupSliderBack()
        setupImageView()
        
        
        ///Setup View
        view.backgroundColor = .systemBackground
    }
}



//MARK: - @IBActions
extension NewsViewController {
    @IBAction func share(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [content!], applicationActivities: nil)
        UIApplication.setupBasicAppTint()
        present(activityVC, animated: true, completion: nil)
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



//MARK: - Main Methods
extension NewsViewController {
    
    //MARK: Private
    private func setupBasicAnimation() {
        let views = [titleLabel, subtitleLabel, contentBack, contentTextView, imageView, dateLabel]
        UIView.animate(withDuration: 0.4) {
            for view in views {
                view?.alpha = 1
            }
        }
    }
    
    private func setupContent() {
        titleLabel.text = " " + mainTitle!
        subtitleLabel.text = "  " + mainTitle!.uppercased()
        dateLabel.text = " " + date!
        contentTextView.text = content!
        imageView.image = image!
    }
    
    private func setupContentBack() {
        contentBack.viewShadows()
        contentBack.layer.cornerRadius = 20
        contentBack.alpha = 0
    }
    
    private func setupContentTextView() {
        contentTextView.alpha = 0
    }
    
    private func setupTitleLabel() {
        titleLabel.textColor = .label
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.backgroundColor = .clear
        titleLabel.alpha = 0
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.font = UIFont.systemFont(ofSize: 13.5, weight: .semibold)
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.alpha = 0
    }
    
    private func setupDateLabel() {
        dateLabel.textColor = .lightGray
        dateLabel.font = UIFont.italicSystemFont(ofSize: 10.5)
        dateLabel.backgroundColor = .clear
        dateLabel.alpha = 0
    }
    
    private func setupSliderBack() {
        sliderBack.alpha = 0
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
    }
}
