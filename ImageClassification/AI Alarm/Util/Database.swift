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
        let alarms: [Alarm]? = decode(UserDefaults.standard.data(forKey: MY_ALARMS))
        return alarms ?? []
    }
    
    static func getIdentifiers(from dateId: String) -> [String] {
        return UserDefaults.standard.stringArray(forKey: dateId) ?? []
    }
    
    // MARK: - Setters
    static func updateMyAlarms(alarms: [Alarm]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alarms), forKey: MY_ALARMS)
    }
    
    static func addIdentifiers(_ identifiers: [String], to dateId: String) {
        UserDefaults.standard.set(identifiers, forKey: dateId)
    }
    
    private static func decode<T: Decodable>(_ data: Data?) -> T? {
        guard let data = data else { return nil }
        return try? PropertyListDecoder().decode(T.self, from: data)
    }
    
}
