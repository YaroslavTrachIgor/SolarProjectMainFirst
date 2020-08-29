//
//  NewsModel.swift
//  SolarProject
//
//  Created by Yaroslav on 28.07.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: - News Model main struct
struct News {
    public var title: String!
    public var content: String!
    public var date: String!
    public var imageURL: String!
}

