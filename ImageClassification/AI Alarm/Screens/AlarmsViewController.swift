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
    
    
    // MARK: -
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
        configureNavigationBar()
    }
    
    // MARK: - Layout
    private func configureNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}

// MARK: - UITableViewDataSource
extension AlarmsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarm") as? AlarmTableViewCell else { return UITableViewCell() }
        
        // TO-DO: - Configure cell
        cell.configure(with: Alarm.sample)
        
        return cell
    }
}
