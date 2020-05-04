//
//  Alarm.swift
//  ImageClassification
//
//  Created by Rodrigo Giglio on 04/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation

enum WeekDay: String, Codable {
    
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"

}

struct Alarm: Codable {
    
    let name: String
    let weekDays: [WeekDay]
    let time: Date
    let isOn: Bool
    let pictureTrigger: String?
    
    // MARK: - Sample
    static let sample: Alarm = Alarm(name: "Wake up looser", weekDays: [.monday, .tuesday, .wednesday], time: Calendar.current.date(byAdding: .hour, value: 5, to: Date())!, isOn: true, pictureTrigger: "notebook")
    
}
