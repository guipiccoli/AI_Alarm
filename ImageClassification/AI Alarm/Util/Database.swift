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
    private static let OBJECT = "object"
    private static let IS_FIRST_TIME = "is_first_time"
    
    // MARK: - Hand Granade
    static func reset() {
        updateMyAlarms(alarms: [])
        updateIsFirstTime(true)
        updateObject(nil)
    }

    // MARK: - Getters
    static func getMyAlarms() -> [Alarm] {
        let alarms: [Alarm]? = decode(UserDefaults.standard.data(forKey: MY_ALARMS))
        return alarms ?? []
    }
    
    static func getIdentifiers(from dateId: String) -> [String] {
        return UserDefaults.standard.stringArray(forKey: dateId) ?? []
    }
    
    static func getObject() -> String? {
        return UserDefaults.standard.string(forKey: OBJECT)
    }
    
    static func getIsFirstTime() -> Bool {
        return UserDefaults.standard.bool(forKey: IS_FIRST_TIME)
    }
    
    // MARK: - Setters
    static func updateMyAlarms(alarms: [Alarm]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alarms), forKey: MY_ALARMS)
    }
    
    static func addIdentifiers(_ identifiers: [String], to dateId: String) {
        UserDefaults.standard.set(identifiers, forKey: dateId)
    }
    
    static func updateObject(_ object: String?) {
        UserDefaults.standard.set(object, forKey: OBJECT)
    }
    
    static func updateIsFirstTime(_ isFirstTime: Bool?) {
        UserDefaults.standard.set(isFirstTime, forKey: IS_FIRST_TIME)
    }
    
    // MARK: - Coding
    private static func decode<T: Decodable>(_ data: Data?) -> T? {
        guard let data = data else { return nil }
        return try? PropertyListDecoder().decode(T.self, from: data)
    }
    
}
