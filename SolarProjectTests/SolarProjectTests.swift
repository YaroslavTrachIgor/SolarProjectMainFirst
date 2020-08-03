//
//  SolarProjectTests.swift
//  SolarProjectTests
//
//  Created by Yaroslav on 14.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import XCTest
@testable import SolarProject

//MARK: - TestsModelTests main class
final class TestsModelTests: XCTestCase {
    
    let titles = PlanetsMenuTableViewControllerModel.planetsTitles
    let basicPreviewStringEnd = PlanetsMenuTableViewControllerModel.PreviewContent.basicPreviewStringEnd
    let content = PlanetsMenuTableViewControllerModel.MainContent.content
    
    func testModelTitles() throws {
        
        ///Test planetsTitles
        XCTAssertEqual(titles[2], "Earth")
        XCTAssertFalse(titles[1] == "Earth")
        XCTAssertTrue(titles[0] == "Mercury")
    }
    
    func testModelPreviewContent() {
        
        ///Test MainContent basicPreviewStringEnd
        XCTAssertEqual(basicPreviewStringEnd, "...")
    }
    
    func testModelMainContent() {
        
        ///Test MainContent content
        XCTAssertTrue(content[0].contains("Mercury is the smallest and innermost planet"))
        XCTAssertTrue(content[4].contains("Jupiter is primarily composed of hydrogen with a quarter of its mass being helium"))
        XCTAssertTrue(content[5].contains("Saturn is the sixth planet from the Sun and the second-largest in the Solar System, after Jupiter. It is a gas giant with an average radius of about nine times that of Earth."))
    }
}



//MARK: - StarsContent Test
extension TestsModelTests {
    func testModelStarsContentTitle() {
        
        ///Test StarsContent title
        XCTAssertTrue(PlanetsMenuTableViewControllerModel.StarsContent.title == "Sun")
    }
    
    func testModelStarsContentPreviewContent() {
        
        ///Test StarsContent previewContent
        XCTAssertTrue(PlanetsMenuTableViewControllerModel.StarsContent.previewContent.contains("The Sun is the star at the center of the  Solar System."))
    }
    
    func testModelStarsContentThemesContentTitles() {
        
        ///Test StarsContent themesContentTitles
        XCTAssertEqual(PlanetsMenuTableViewControllerModel.StarsContent.themesContentTitles[2], "Composition")
        XCTAssertEqual(PlanetsMenuTableViewControllerModel.StarsContent.themesContentTitles[6], "Core")
        XCTAssertEqual(PlanetsMenuTableViewControllerModel.StarsContent.themesContentTitles[8], "Tachocline")
    }
    
    func testModelStarsContentThemesContent() {
        
        ///Test StarsContent themesContent
        XCTAssertTrue(PlanetsMenuTableViewControllerModel.StarsContent.themesContent[2].contains("The Sun is composed primarily of the chemical elements hydrogen and helium."))
        XCTAssertTrue(PlanetsMenuTableViewControllerModel.StarsContent.themesContent[4].contains("Various authors have considered the existence of a gradient in the isotopic compositions of solar and planetary noble gases, e.g."))
    }
}
