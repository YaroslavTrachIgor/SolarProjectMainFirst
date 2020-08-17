//
//  NewsModel.swift
//  SolarProject
//
//  Created by Yaroslav on 28.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: - NewsModel
final class NewsModel {
    
    //MARK: Fileprivate
    typealias NewsContentType = [String]
    
    
    //MARK: Public
    public var newsTitles = NewsContentType()
    public var newsContents = NewsContentType()
    public var newsDates = NewsContentType()
    public var newsImagesStringURLs = NewsContentType()
}
