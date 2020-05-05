//
//  AddAlarmViewController.swift
//  ImageClassification
//
//  Created by Rodrigo Giglio on 05/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

protocol AddAlarmViewControllerDelegate: class {
    func willDisapear()
}

class AddAlarmViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var timeDatePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    /// Weekday buttons
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    
    
    // MARK: - Variables
    var weekDayButtons: [UIButton] = []
    var selectedWeekDays: [Int] = []
    weak var delegate: AddAlarmViewControllerDelegate?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureWeekDayButtons()
    }
    

    // MARK: - Layout
    private func configureNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func refreshWeekdayButtonsLayout() {
        
        for button in weekDayButtons {
            
            if selectedWeekDays.contains(button.tag) {
                
                /// In case day is selected
                button.setTitleColor(UIColor(named: "Main Blue"), for: .normal)
                
            }
            else {
                
                /// In case day is not selected
                button.setTitleColor(UIColor(named: "Main Text"), for: .normal)

            }
        }
    }
    
    
    // MARK: - Private Methods
    private func configureWeekDayButtons() {
        
        mondayButton.tag = 1
        tuesdayButton.tag = 2
        wednesdayButton.tag = 3
        thursdayButton.tag = 4
        fridayButton.tag = 5
        saturdayButton.tag = 6
        sundayButton.tag = 7
        
        weekDayButtons = [ mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton]
    }
    
    private func toggleButton(with tag: Int) {
        
        if selectedWeekDays.contains(tag) {
            if let index = selectedWeekDays.firstIndex(of: tag) {
                selectedWeekDays.remove(at: index)
            }
        }
        else {
            selectedWeekDays.append(tag)
        }
    }
    
    private func saveAlarm() {
        
        /// Parse data
        let weekDays: [WeekDay] = selectedWeekDays.map { WeekDay.from(tag: $0) }
        let name: String? = titleTextField.text
        let time: Date = timeDatePicker.date
        let isOn: Bool = true
        let pictureTrigger: String? = nil
        
        /// Initiate new alarm
        let alarm = Alarm(name: name, weekDays: weekDays, time: time, isOn: isOn, pictureTrigger: pictureTrigger)
        
        /// Appends new alarm to current
        var alarms = Database.getMyAlarms()
        alarms.append(alarm)
        
        /// Save the new alarm list
        Database.updateMyAlarms(alarms: alarms)
    }
    
    
    // MARK: - Outlet Actions
    @IBAction func weekButtonClick(_ sender: UIButton) {
        
        toggleButton(with: sender.tag)
        refreshWeekdayButtonsLayout()
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        saveAlarm()
        delegate?.willDisapear()
        self.dismiss(animated: true, completion: nil)
    }
}
