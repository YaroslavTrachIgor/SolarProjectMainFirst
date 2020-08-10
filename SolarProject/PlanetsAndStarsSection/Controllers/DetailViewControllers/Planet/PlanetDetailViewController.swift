//
//  ViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit
import GoogleMobileAds

//MARK: - PlanetDetailViewControllerSetupProtocol protocol
protocol PlanetDetailViewControllerContentSetupProtocol {
    func setupContentTextViewBack()
    func setupContent()
}



//MARK: - PlanetDetailViewControllerSetupProtocol protocol
protocol PlanetDetailViewControllerProtocol: PlanetDetailViewControllerContentSetupProtocol {
    
    // Setup Animations func
    func setupAnimation()
    
    // Add View To Analytics func
    func addViewToAnalytics()
}



//MARK: - PlanetDetailViewController main class
final class PlanetDetailViewController: BasicViewController {
    
    //MARK: Presenter
    var presenter: PlanetDetailViewControllerPresenterContentSetupProtocol {
        return PlanetDetailViewControllerPresenter()
    }
    
    //MARK: @IBOutlets
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentBack: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var sliderBack: ContentBack!
    @IBOutlet weak var slider: BasicFontChangeSlider!
    @IBOutlet weak var sliderBackShowerButton: UIBarButtonItem!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var planetTitleLabel: UILabel!
    @IBOutlet weak var contentTypeLabel: UILabel!
    
    //Add Bunner
    @IBOutlet weak var bunner: GADBannerView!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setup Content
        setupContent()
        
        ///Setup UI
        setupBasicViewControllerUI()
        
        ///Add view to analytics
        addViewToAnalytics()
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
        setupSegmentedControl()
        setupContentTextView()
        setupSliderBack()
        setupImageButton()
        setupNavigationItem()
        setupAddBunner()
    }
}



//MARK: - @IBActions
extension PlanetDetailViewController {
    @IBAction func changeContent(_ sender: UISegmentedControl) {
        contentTextView.setupContentWithAnimation(text: presenter.setupSwitchedContent(with: sender.selectedSegmentIndex))
        contentTypeLabel.setupContentWithAnimation(text: presenter.setupContentTypeInfo(with: sender.selectedSegmentIndex))

    }
    
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



//MARK: - PlanetDetailViewControllerSetupProtocol extension
extension PlanetDetailViewController: PlanetDetailViewControllerProtocol {
    
    //MARK: Add View To Analytics
    internal func addViewToAnalytics() {
        presenter.addViewToAnalytics()
    }
    
    
    //MARK: Setup Animations
    internal func setupAnimation() {
        let views = [contentBack, segmentedControl, imageButton]
        
        UIView.animate(withDuration: 0.4) {
            for view in views {
                view!.alpha = 1
            }
        }
    }
    
    
    //MARK: Setup UI
    fileprivate func setupImageButton() {
        imageButton.setupArticleDetailButton(title: "  Images  ")
        imageButton.layer.cornerRadius = BasicProperties.cornerRadius
    }
    
    fileprivate func setupSegmentedControl() {
        segmentedControl.segmentedControlBasics()
    }
    
    
    //MARK: Internal
    internal func setupContentTextViewBack() {
        contentBack.viewShadows()
        contentBack.layer.cornerRadius = BasicProperties.cornerRadius
        contentBack.alpha = 0
    }
    
    internal func setupContent() {
        contentTextView.setupContentWithAnimation(text: presenter.setupMostContent())
        navigationItem.title = presenter.setupTitles()
        planetTitleLabel.text = presenter.setupTitles()
        contentTypeLabel.text = "Most Information"
    }
    
    
    //MARK: Private
    fileprivate func setupContentTextView() {
        let fontSize: CGFloat = 18
        contentTextView.font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        contentTextView.isEditable = false
        contentTextView.isSelectable = true
        contentTextView.layer.cornerRadius = BasicProperties.cornerRadius
    }

    fileprivate func setupSliderBack() {
        sliderBack.isHidden = true
        sliderBack.alpha = 0
        sliderBack.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    fileprivate func setupNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupAddBunner() {
        bunner.adUnitID = presenter.setupBasicAdUnitId()
        bunner.rootViewController = self
        bunner.load(GADRequest())
    }
}
