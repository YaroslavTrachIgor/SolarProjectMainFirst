//
//  PersonalAnalyticsModel.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 28.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import Charts

//MARK: - PersonalAnalyticsModel
final class PersonalAnalyticsModel {
    
    //MARK: Shared
    static let shared = PersonalAnalyticsModel()
    
    
    //MARK: Titles
    static let titles =
    [
        "Sun Article Views Count",
        "Mercury Article Views Count",
        "Venus Article Views Count",
        "Earth Article Views Count",
        "Mars Article Views Count",
        "Jupiter Article Views Count",
        "Saturn Article Views Count",
        "Neptune Article Views Count",
        "Uranus Article Views Count",
        "Pluto Article Views Count",
    ]
    
    static let subtitles =
    [
        "SUN ARTICLE ANALYTICS",
        "MERCURY ARTICLE ANALYTICS",
        "VENUS ARTICLE ANALYTICS",
        "EARTH ARTICLE ANALYTICS",
        "MARS ARTICLE ANALYTICS",
        "JUPITER ARTICLE ANALYTICS",
        "SATURN ARTICLE ANALYTICS",
        "NEPTUNE ARTICLE ANALYTICS",
        "URANUS ARTICLE ANALYTICS",
        "PLUTO ARTICLE ANALYTICS",
    ]
    
    var chartsItems: [PieChartDataEntry] {
        return [
            PieChartDataEntry(value: Double(views[0]), label: PlanetsMenuTableViewControllerModel.StarsContent.title),
            PieChartDataEntry(value: Double(views[1]), label: PlanetsMenuTableViewControllerModel.planetsTitles[0]),
            PieChartDataEntry(value: Double(views[2]), label: PlanetsMenuTableViewControllerModel.planetsTitles[1]),
            PieChartDataEntry(value: Double(views[3]), label: PlanetsMenuTableViewControllerModel.planetsTitles[2]),
            PieChartDataEntry(value: Double(views[4]), label: PlanetsMenuTableViewControllerModel.planetsTitles[3]),
            PieChartDataEntry(value: Double(views[5]), label: PlanetsMenuTableViewControllerModel.planetsTitles[4]),
            PieChartDataEntry(value: Double(views[6]), label: PlanetsMenuTableViewControllerModel.planetsTitles[5]),
            PieChartDataEntry(value: Double(views[7]), label: PlanetsMenuTableViewControllerModel.planetsTitles[6]),
            PieChartDataEntry(value: Double(views[8]), label: PlanetsMenuTableViewControllerModel.planetsTitles[7]),
            PieChartDataEntry(value: Double(views[9]), label: PlanetsMenuTableViewControllerModel.planetsTitles[8])
        ]
    }
    
    
    //MARK: Views Array
    var views = defaults.value(forKey: "ViewsKey") as? [Int] ?? [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
}
