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
    
    var tag: Int {
        
        switch self {
        
            case .monday: return 1
            case .tuesday: return 2
            case .wednesday: return 3
            case .thursday: return 4
            case .friday: return 5
            case .saturday: return 6
            case .sunday: return 7
        }
    }
    
    static func from(tag: Int) -> WeekDay {
        
        switch tag {
        
            case 1: return .monday
            case 2: return .tuesday
            case 3: return .wednesday
            case 4: return .thursday
            case 5: return .friday
            case 6: return .saturday
            case 7: return .sunday
            default: return .monday
        }
    }
}

struct Alarm: Codable {
    
    let name: String?
    let weekDays: [WeekDay]
    let time: Date
    let isOn: Bool
    let pictureTrigger: String?
    
    // MARK: - Sample
    static let sample: Alarm = Alarm(name: "Wake up looser", weekDays: [.monday, .tuesday, .wednesday], time: Calendar.current.date(byAdding: .hour, value: 5, to: Date())!, isOn: true, pictureTrigger: "notebook")
    
}
