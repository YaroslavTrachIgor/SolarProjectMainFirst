//
//  RemindersModel.swift
//  SolarProject
//
//  Created by Yaroslav Trach on 01.06.2020.
//  Copyright © 2020 Yaroslav Trach. All rights reserved.
//

import Foundation

//MARK: UserDefaults
let defaults = UserDefaults.standard

//MARK: Reminders content arrays
typealias ReminderArrayType = [String]

var reminders = ReminderArrayType()
var dates     = ReminderArrayType()


//Arrays for Completed reminders
var completedReminders = ReminderArrayType()
var completedDates     = ReminderArrayType()
