//
//  AlarmsViewController.swift
//  ImageClassification
//
//  Created by Rodrigo Giglio on 04/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class AlarmsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    
    
    // MARK: - Variables
    var alarms: [Alarm] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        configureNavigationBar()
        reloadData()
        askForNotificationPermition()
    }
    
    // MARK: - Layout
    private func configureNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - Data Fetching
    private func reloadData() {
        
        fetchAlarms()
        tableView.reloadData()
    }
    
    private func fetchAlarms() {
        
        let alarms = Database.getMyAlarms()
              
        self.alarms = alarms.sorted(by: { $0.time.compare($1.time) == .orderedAscending })
    }
    
    
    // MARK: - Private Methods
    private func askForNotificationPermition() {
        
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Permition granted")
            } else {
                print("Permition denied")
            }
        }
    }
    

    // MARK: - Outlet Actions
    @IBAction func editButtonClick(_ sender: UIBarButtonItem) {
        tableView.isEditing.toggle()
        editButton.setTitle(tableView.isEditing ? "Done" : "Edit", for: .normal)
    }
    

}

extension AlarmsViewController {
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navigationController = segue.destination as? UINavigationController {
            if let addAlarmVC = navigationController.viewControllers[0] as? AddAlarmViewController {
                addAlarmVC.delegate = self
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension AlarmsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.alarms.count == 0 ? 1 : self.alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// In case there is no alarm found
        if self.alarms.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "placeholder") else { return UITableViewCell() }
            return cell
        }
        
        /// In case at least one alarm was found
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarm") as? AlarmTableViewCell
            else { return UITableViewCell() }
        
        cell.configure(with: self.alarms[indexPath.row])
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension AlarmsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alarm = alarms.remove(at: indexPath.row)
            
            NotificationHelper.removeAlarm(alarm)
            
            Database.updateMyAlarms(alarms: alarms)
            
            if alarms.count > 0 {
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            else {
                
                reloadData()
            }
        }
    }
}


// MARK: - AddAlarmViewControllerDelegate
extension AlarmsViewController: AddAlarmViewControllerDelegate {
    func willDisapear() {
        reloadData()
    }
}
