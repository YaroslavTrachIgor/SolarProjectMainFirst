//
//  StarThemeDeteailViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 30.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit
import GoogleMobileAds

//MARK: - PlanetDetailViewControllerSetupProtocol protocol
protocol StarThemeDeteailViewControllerContentSetupProtocol {
    func setupContent()
}



//MARK: - PlanetDetailViewControllerSetupProtocol protocol
protocol StarThemeDeteailViewControllerProtocol: StarThemeDeteailViewControllerContentSetupProtocol {
    
    //MARK: Setup Animations
    func setupAnimation()
}



//MARK: - StarThemeDeteailViewController main class
final class StarThemeDeteailViewController: BasicViewController {
    
    //MARK: Presenter
    var presenter: StarThemeDeteailViewControllerPresenterProtocol {
        return StarThemeDeteailViewControllerPresenter()
    }
    
    //MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: ContentTextView!
    @IBOutlet weak var contentBack: ContentBack!
    @IBOutlet weak var slider: BasicFontChangeSlider!
    @IBOutlet weak var sliderBack: ContentBack!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var fontChangeButton: UIBarButtonItem!
    @IBOutlet weak var bunner: GADBannerView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        ///Setup Content
        setupContent()
        
        ///Setup UI
        setupBasicViewControllerUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setTabBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        setTabBarHidden(false)
    }
    
    
    //MARK: BasicViewControllerProtocol method
    internal func setupBasicViewControllerUI() {
        
        ///Setup UI
        setupContentTextViewBack()
        setupSliderBack()
        setupContentTextViewBack()
        setupAddBunner()
        setupTitleLabel()
        setupSubtitleLabel()
        
        ///Setup View
        view.backgroundColor = .systemBackground
    }
}



//MARK: - @IBActions
extension StarThemeDeteailViewController {
    @IBAction func share(_ sender: Any) {
        guard let content = contentTextView.text else { return }
        ActivityVCManeger.showBasic(content: content, for: self)
        UIApplication.setupBasicAppTint()
    }
    
    @IBAction func changeFont(_ sender: UISlider) {
        let fontSize = CGFloat(slider.value)
        var fontName = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        
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
        fontChangeButton.viewShowingWithAnimation(animating: sliderBack, main: self.view, nil)
    }
}



//MARK: - PlanetDetailViewControllerSetupProtocol extension
extension StarThemeDeteailViewController: StarThemeDeteailViewControllerProtocol {
    
    //MARK: Setup Animation
    internal func setupAnimation() {
        let views = [contentBack, titleLabel]
        
        UIView.animate(withDuration: 0.4) {
            for view in views {
                view!.alpha = 1
            }
        }
    }
    
    
    //MARK: Setup UI
    private func setupSliderBack() {
        sliderBack.alpha = 0
        sliderBack.isHidden = true
    }
    
    private func setupContentTextViewBack() {
        contentBack.alpha = 0
    }
    
    private func setupAddBunner() {
        bunner.adUnitID = "ca-app-pub-8702634561077907/9618797231"
        bunner.rootViewController = self
        bunner.load(GADRequest())
    }
    
    private func setupTitleLabel() {
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.font = font
        titleLabel.textColor = .black
        titleLabel.alpha = 0
    }
    
    private func setupSubtitleLabel() {
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        subtitleLabel.font = font
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.alpha = 0
    }
    
    
    //MARK: Setup Content
    internal func setupContent() {
        contentTextView.setupContentWithAnimation(text: presenter.setupTextViewContent())
        titleLabel.text = presenter.setupTitleContent()
        subtitleLabel.text = presenter.setupTitleContent().uppercased()
        navigationItem.title = ""
    }
}
