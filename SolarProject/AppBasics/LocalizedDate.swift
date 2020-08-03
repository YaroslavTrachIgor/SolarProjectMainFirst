//
//  LocalizedDate.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 13.05.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation

//MARK: - LocalizedDate struct
struct LocalizedDate {
    
    //MARK: String
    var location: String
    var datePosix: String
    
    //MARK: DateFormatter
    let dateFormatter = DateFormatter()
    
    //MARK: Date
    let date = Date()

    public func returnDate() -> String {
        let local = Locale(identifier: location)
        dateFormatter.locale = local
        dateFormatter.setLocalizedDateFormatFromTemplate(datePosix)
        return dateFormatter.string(from: date)
    }

    init(_ location: String, datePosix: String ){
        self.location = location
        self.datePosix = datePosix
    }
}
