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
    
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuration
    func configure(with alarm: Alarm) {
        
        nameLabel.text = alarm.name
        timeLabel.text = alarm.time.hourString
        isOnSwitch.isOn =  alarm.isOn
        remainingTimeLabel.text = hourString(from: alarm.time.hours(sinceDate: Date()))

        imageButton.tintColor =
            alarm.pictureTrigger != nil ?
                UIColor(named: "Main Blue") : UIColor(named: "Sub Text")
    }
    
    func hourString(from hourCount: Int?) -> String {
        
        guard let hourCount = hourCount else { return "" }
        
        if hourCount == 0 { return "less than an hour remaining" }
        if hourCount == 1 { return "1 hour remaining" }
        
        return "\(hourCount) hours remaining"
    }
}
