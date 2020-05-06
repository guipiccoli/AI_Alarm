//
//  NotificationHelper.swift
//  ImageClassification
//
//  Created by Rodrigo Giglio on 06/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import NotificationCenter

class NotificationHelper {
    
    
    public static func setAlarm(_ alarm: Alarm) {
        
        if alarm.weekDays.isEmpty {
            
            
            // In case the alarm is for today
            if Date() < alarm.time {
                
                setAlarmNotification(for: alarm.time, named: alarm.name)
            }
                
                // In case the alarm is for tomorrow
            else {
                
                var dateComponent = DateComponents()
                dateComponent.day = 1
                guard let tomorrow = Calendar.current.date(byAdding: dateComponent, to: alarm.time) else { return }
                
                setAlarmNotification(for: tomorrow, named: alarm.name)
            }
            
        }
        else {
            
            for weekDay in alarm.weekDays {
                setAlarmNotification(for: alarm.time, weekDay: weekDay, named: alarm.name)
            }
            
        }
        
    }
    
    public static func removeAlarm(_ alarm: Alarm) {
        
        if alarm.weekDays.isEmpty {
            
            // In case the alarm is for today
            if Date() < alarm.time {
                
                removeAlarmNotification(for: alarm.time)
            }
                
                // In case the alarm is for tomorrow
            else {
                
                var dateComponent = DateComponents()
                dateComponent.day = 1
                guard let tomorrow = Calendar.current.date(byAdding: dateComponent, to: alarm.time) else { return }
                
                removeAlarmNotification(for: tomorrow)
            }
            
        }
            
        else {
            
            for weekDay in alarm.weekDays {
                
                removeAlarmNotification(for: alarm.time, weekDay: weekDay)
            }
        }
    }
    
    private static func setAlarmNotification(for date: Date, weekDay: WeekDay? = nil, named name: String?) {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = name ?? "Alarm"
        content.subtitle = "Open the app to stop it."
        content.userInfo = ["type": "alarm"]
        content.sound =  UNNotificationSound.init(named:UNNotificationSoundName(rawValue: "Alarm.mp3"))
        
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minutes
        dateComponents.second = 0
        
        var weekDayID = ""
        if let weekDay = weekDay {
            dateComponents.weekday = weekDay.tag
            weekDayID = "+\(weekDay.tag)"
        }
        else {
            dateComponents.day = day
        }
                
        let identifier = date.toString(dateFormat: "yyyy-MM-dd HH:mm:ss\(weekDayID)")
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request)
    }
    
    private static func removeAlarmNotification(for date: Date, weekDay: WeekDay? = nil) {
        
        
        var weekDayID = ""
        if let weekDay = weekDay {
            weekDayID = "+\(weekDay.tag)"
        }
      
        let identifier = date.toString(dateFormat: "yyyy-MM-dd HH:mm:ss\(weekDayID)")
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifier] )
    }
}
