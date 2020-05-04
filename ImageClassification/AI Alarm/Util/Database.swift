//
//  Database.swift
//  ImageClassification
//
//  Created by Rodrigo Giglio on 04/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation

class Database {
    
    // MARK: - Identifiers
    private static let MY_ALARMS = "my_alarms"
    
    // MARK: - Getters
    static func getMyAlarms() -> [Alarm] {
        return UserDefaults.standard.value(forKey: MY_ALARMS) as? [Alarm] ?? []
    }
    
    // MARK: - Setters
    static func updateMyAlarms(alarms: [Alarm]) {
        UserDefaults.standard.set(alarms, forKey: MY_ALARMS)
    }
}
