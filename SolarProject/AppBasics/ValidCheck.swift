//
//  String.swift
//  GoodBiology
//
//  Created by Yaroslav Trach on 19.04.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import Foundation

// MARK: - String extension for Full name validation 
public extension String {

    /// Maps current string against a regular expression and returns all matched strings
    ///
    /// - Parameter regex: A string representing a regular expression pattern
    /// - Returns: Array of all matched strings or empty [] if no matches or pattern is invalid
    func matches(for regex: String) -> [String] {
        let nsString = self as NSString
        guard let regex = try? NSRegularExpression(pattern: regex) else { return [] }
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
        let results = matches.map { nsString.substring(with: $0.range)}
        return results
    }

    /// Evaluates a string as a valid or invalid full name. The criteria is to accept all aphabets
    /// along with alternate characters e.g. é, è, à, ¸â, ê, ë.... This method will return true against
    /// all below names
    ///
    ///  - Mathias d'Arras
    ///  - Martin Luther King, Jr.
    ///  - Hector Sausage-Hausen
    ///
    /// - Returns: true if name is valid otherwise false
    func isValidFullName() -> Bool {
        let pattern = "^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'_-]+$"
        return (self.matches(for: pattern).count > 0)
    }

    /// Evaluates a string as a valid or invalid email.
    ////This method will return true against all below emails
    ///
    ///  - jonhDoe@gmail.com
    ///  - jonhDoe@gmail.com.de
    ///
    /// And false against emails below
    ///
    ///  - jonhDoe@@.c
    ///  - jonhDoe@csd.com....
    ///  - jonhDoe@.com
    ///  - jonhDoe@com.de.c
    ///
    /// - Returns: true if email is valid otherwise false
    func isValidEmail() -> Bool {
        let pattern =  "^[A-Za-z0-9_-]+(?:\\.[A-Za-z0-9_-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\\.)+(?:[A-Za-z]{2,})$"

        return (self.matches(for: pattern).count > 0)
    }
}
