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
extension MenuContentModel {
    
    //MARK: MoreItemsContent struct
    public struct MoreItemsContent {
        
        ///Titles
        static let titles = [
            "Support",
            "Reminders",
            "Articles",
            "Images"
        ]
        
        ///Titles Descriptions
        static let titlesDescriptions = [
            "Use the SUPPORT button to go to the screen where you can contact us.",
            "Use the REMINDERS button to go to the screen where you can see your reminders.",
            "Use the SUN ARTICLES button to go to the screen where you can watch on Sun articles.",
            "Use the SUN IMAGES button to go to the screen where you can watch on Sun images."
        ]
        
        ///Background colors
        static let backColors: [UIColor] = [.blue, .red, #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), .purple]
        
        ///Buttons titles
        static let buttonsTitles = ["SUPPORT", "REMINDERS", "SUN ARTICLES", "SUN IMAGES"]
        
        ///Segues Identifires
        static let segues = ["SupportSegue", "RemindersSegue", "ArticlesSegue", "ImagesSegue"]
        
        ///Images
        static let images: [UIImage] = [#imageLiteral(resourceName: "Снимок экрана 2020-07-29 в 16.10.25"), #imageLiteral(resourceName: "Снимок экрана 2020-08-03 в 21.30.43"), #imageLiteral(resourceName: "Снимок экрана 2020-08-03 в 21.45.16"), #imageLiteral(resourceName: "Снимок экрана 2020-08-03 в 22.06.03")]
    }
}
