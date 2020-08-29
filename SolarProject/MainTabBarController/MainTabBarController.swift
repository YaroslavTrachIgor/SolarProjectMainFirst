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
        setupTabBar()
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
    private func setupTabBar() {
        let backColor: UIColor = .systemBackground
        tabBar.barTintColor = backColor
        tabBar.backgroundColor = backColor
    }
}
