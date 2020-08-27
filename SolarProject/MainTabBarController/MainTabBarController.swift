//
//  MainTabBarController.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 16.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import UIKit

//MARK: - MainTabBarControllerProtocol protocol
protocol MainTabBarControllerProtocol {
    func setupDelegate()
}



//MARK: - MainTabBarController main class
final class MainTabBarController: UITabBarController {

    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegate()
        setupShadow()
        setupCorners()
    }
}



//MARK: - UITabBarControllerDelegate extension
extension MainTabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else { return false /* Make sure you want this as false */ }
            
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.35, options: [.transitionCrossDissolve], completion: nil)
        }
            
        return true
    }
}

    
    
//MARK: - MainTabBarControllerProtocol extension
extension MainTabBarController: MainTabBarControllerProtocol {
    
    //MARK: Delegate
    internal func setupDelegate() {
        delegate = self
    }
    
    //MARK: Private
    private func setupShadow() {
        
        ///Setup tabBar shadow
        tabBar.isTranslucent = false

        tabBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        tabBar.layer.shadowColor = #colorLiteral(red: 0.9103026095, green: 0.9103026095, blue: 0.9103026095, alpha: 1)
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowRadius = 35
        
        ///Hide separator
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
    
    private func setupCorners() {
        
        ///Setup tabBar cornerRadius
        tabBar.layer.masksToBounds = false
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = BasicProperties.cornerRadius + 12
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
