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
        // Initialization code
    }
    
    // MARK: - Configuration
    func configure(with alarm: Alarm) {
        
        nameLabel.text = alarm.name
        timeLabel.text = alarm.time.hourString
        isOnSwitch.isOn =  alarm.isOn
        imageButton.tintColor = alarm.pictureTrigger != nil ? UIColor(named: "Main Blue") : UIColor(named: "Sub Text")
        remainingTimeLabel.text = "\(alarm.time.hours(sinceDate: Date()) ?? 0) hours remaining"
        
        
    }

}
