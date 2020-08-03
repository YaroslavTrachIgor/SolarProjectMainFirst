//
//  MoreItemsContent.swift
//  SolarProject
//
//  Created by Yaroslav on 03.08.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import UIKit

//MARK: - PlanetsMenuTableViewControllerModel extension
extension PlanetsMenuTableViewControllerModel {
    
    //MARK: MoreItemsContent struct
    public struct MoreItemsContent {
        
        ///Titles
        static let titles = [
            "Support",
            "Reminders",
            "Sun Articles",
            "Sun Images"
        ]
        
        ///Titles Descriptions
        static let titlesDescriptions = [
            "Use the SUPPORT button to go to the screen where you can contact us.",
            "Use the REMINDERS button to go to the screen where you can contact us",
            "Use the SUN ARTICLES button to go to the screen where you can contact us",
            "Use the SUN IMAGES button to go to the screen where you can contact us"
        ]
        
        ///Background colors
        static let backColors: [UIColor] = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]
        
        ///Buttons titles
        static let buttonsTitles = ["SUPPORT", "REMINDERS", "SUN ARTICLES", "SUN IMAGES"]
        
        ///Segues Identifires
        static let segues = ["SupportSegue", "RemindersSegue", "ThemesSegue", "SunImagesSegue"]
    }
}
