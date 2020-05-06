//
//  AlarmTableViewCell.swift
//  ImageClassification
//
//  Created by Rodrigo Giglio on 04/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weekDaysStack: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var isOnSwitch: UISwitch!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    /// Week Days
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thusdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    
    
    // MARK: - Variables
    var alarm: Alarm?
    
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuration
    func configure(with alarm: Alarm) {
        
        self.alarm = alarm
        
        nameLabel.text = alarm.name ?? "Alarm"
        timeLabel.text = alarm.time.hourString
        isOnSwitch.isOn =  alarm.isOn
        remainingTimeLabel.text = hourString(from: alarm.time.hours(sinceDate: Date()))

        imageButton.tintColor =
            alarm.pictureTrigger != nil ?
                UIColor(named: "Main Blue") : UIColor(named: "Sub Text")
        
        for day in alarm.weekDays {
            
            switch day {
                
            case .monday: mondayLabel.isHidden = false
            case .tuesday: tuesdayLabel.isHidden = false
            case .wednesday: wednesdayLabel.isHidden = false
            case .thursday: thusdayLabel.isHidden = false
            case .friday: fridayLabel.isHidden = false
            case .saturday: saturdayLabel.isHidden = false
            case .sunday: sundayLabel.isHidden = false
                
            }
        }
    }
    
    func hourString( from hourCount: Int?) -> String {
        
        guard let hourCount = hourCount else { return "" }
        
        if hourCount < 0 { return "" }
        if hourCount == 0 { return "less than an hour remaining" }
        if hourCount == 1 { return "1 hour remaining" }
        
        return "\(hourCount) hours remaining"
    }
    
    // MARK: - Outlet Actions
    @IBAction func isOnSwitchValueChanged(_ sender: Any) {
        
        guard var alarm = self.alarm else { return }
        
        alarm.isOn.toggle()

        NotificationHelper.removeAlarm(alarm)
        
        let alarms = Database.getMyAlarms()
        var newAlarms = alarms.filter { $0.time != alarm.time }
        
        newAlarms.append(alarm)
        
        Database.updateMyAlarms(alarms: newAlarms)
        
        if alarm.isOn {
            NotificationHelper.setAlarm(alarm)
        }
    }
}
