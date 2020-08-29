//
//  StarDeteailViewController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 29.05.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds
import SPStorkController
import SPFakeBar

//MARK: Keys
extension StarDeteailViewController {
    public enum Keys: String {
        
        //MARK: NotficationNames
        enum NotficationNames: String {
            case imagesShowVCNotificationName = "ImagesShowVCNotificationName"
            case themesShowVCNotificationName = "ThemesShowVCNotificationName"
        }
        
        
        //MARK: Segues
        enum Segues: String {
            case showImagesSegue = "ShowImagesSegue"
            case showThemesSegue = "ShowThemesSegue"
        }
        
        case starDetailMoreVC = "StarDetailMoreVC"
    }
}



//MARK: - StarDeteailViewController main class
final class StarDeteailViewController: BasicViewController, StarDetailDelegate {
    
    //MARK: - Presenter
    var presenter: StarDetailVCPresenterProtocol {
        return StarDetailVCPresenter()
    }
    
    
    //MARK: @IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var contentBack: ContentBack!
    @IBOutlet weak var contentTextView: ContentTextView!
    @IBOutlet weak var sliderBack: ContentBack!
    @IBOutlet weak var slider: BasicFontChangeSlider!
    @IBOutlet weak var sliderBackShowerButton: UIBarButtonItem!
    @IBOutlet weak var themesGoImage: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var bunner: GADBannerView!
    @IBOutlet weak var openInWikiButton: UIButton!
    
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setup UI
        setupBasicViewControllerUI()
        
        ///Add View to Analytics
        addViewToAnalytics()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupViewDidAppeareAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setTabBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        setTabBarHidden(false)
    }
    
    
    //MARK: BasicViewControllerProtocol
    internal func setupBasicViewControllerUI() {
        
        ///Setup UI
        setupSegmentedControl()
        setupContentBack()
        setupContentTextView()
        setupSliderBack()
        setupAddBunner()
        setupMoreButton()
        setupThemesGoImage()
        setupWikiButton()
        
        ///Setup View
        view.backgroundColor = .systemBackground
    }
    
    
    //MARK: StarDetailDelegate
    internal func setSegue(with id: Int?) {
        switch id {
        case nil:
            break
        case 1:
            performSegue(withIdentifier: Keys.Segues.showImagesSegue.rawValue, sender: self)
        case 2:
            performSegue(withIdentifier: Keys.Segues.showThemesSegue.rawValue, sender: self)
        default:
            break
        }
    }
}



//MARK: - @IBActions
extension StarDeteailViewController {
    @IBAction func changeContent(sender: UISegmentedControl) {
        contentTextView.setupContentWithAnimation(text: presenter.setupSwitchedContent(with: sender.selectedSegmentIndex))
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
    
    @IBAction func more(sender: Any) {
        let transitonDelegate = SPStorkTransitioningDelegate()
        let vc = storyboard?.instantiateViewController(identifier: Keys.starDetailMoreVC.rawValue) as! StarDetailMoreVC
        
        ///Setup transitonDelegate
        transitonDelegate.customHeight = 195
        transitonDelegate.cornerRadius = 9
        vc.transitioningDelegate = transitonDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.delegate = self
        
        ///Present vc
        present(vc, animated: true)
    }
    
    @IBAction func openWikPage(_ sender: Any) {
        showSafariVC(with: "https://en.wikipedia.org/wiki/Sun")
    }
}



//MARK: - StarDeteailViewController Main Methods extnsion
extension StarDeteailViewController {
    
    //MARK: Add view to analytics
    fileprivate func addViewToAnalytics() {
        PersonalAnalyticsModel.shared.views[0] += 1
        defaults.set(PersonalAnalyticsModel.shared.views, forKey: "ViewsKey")
    }
    
    
    //MARK: Setup ViewDidAppeare Animation
    fileprivate func setupViewDidAppeareAnimation() {
        let views = [openInWikiButton, segmentedControl, contentBack, moreButton, themesGoImage]
        UIView.animate(withDuration: 0.4) {
            for view in views {
                view!.alpha = 1
            }
        }
    }
    
    
    //MARK: Setup UI
    fileprivate func setupWikiButton() {
        openInWikiButton.backgroundColor = .clear
        openInWikiButton.setTitle("Open In Wikipedia", for: .normal)
        openInWikiButton.setTitleColor(BasicProperties.color, for: .normal)
        openInWikiButton.alpha = 0
        openInWikiButton.tintColor = BasicProperties.color
    }
    
    fileprivate func setupAddBunner() {
        bunner.adUnitID = presenter.setupBasicAddUnitId()
        bunner.rootViewController = self
        bunner.load(GADRequest())
    }
    
    fileprivate func setupSegmentedControl() {
        segmentedControl.segmentedControlBasics()
    }
    
    fileprivate func setupContentBack() {
        contentBack.alpha = 0
    }
    
    fileprivate func setupContentTextView() {
        contentTextView.text = presenter.setupMostContent()
        contentTextView.isScrollEnabled = true
    }
    
    fileprivate func setupSliderBack() {
        sliderBack.isHidden = true
        sliderBack.alpha = 0
        sliderBack.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    fileprivate func setupMoreButton() {
        moreButton.setupArticleDetailButton(title: "More")
        moreButton.layer.cornerRadius = BasicProperties.cornerRadius
    }
    
    //MARK: Private
    private func setupThemesGoImage() {
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        let imageName = "chevron.compact.up"
        let image = UIImage(systemName: imageName, withConfiguration: config)
        themesGoImage.image = image
        themesGoImage.tintColor = .tertiaryLabel
        themesGoImage.alpha = 0
    }
}
