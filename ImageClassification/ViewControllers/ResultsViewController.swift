//
//  ResultsViewController.swift
//  ImageClassification
//
//  Created by Guilherme Piccoli on 30/04/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

protocol ResultsViewControllerDelegate: class {
    
    func didScanObject()
    
}

class ResultsViewController: UIViewController {
    
    var inferenceResult: Result? = nil
    weak var delegate: ResultsViewControllerDelegate?
    
    @IBOutlet weak var resultTableView: UITableView!
    
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
    var isRegisteringObject: Bool = true
    
    var resultTuple: (name: String, precision: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        let info = displayStringsForResults(position: 0)
        print(info)
        
        if isRegisteringObject {
            confirmButtonOutlet.isHidden = false
            cancelButtonOutlet.isHidden = false
        }
        else {
            confirmButtonOutlet.isHidden = true
            cancelButtonOutlet.isHidden = true
        }
    }
    
    func displayStringsForResults(position: Int) -> (name: String, precision: String) {
        
        var fieldName: String = ""
        var info: String = ""
        
        guard let tempResult = inferenceResult, tempResult.inferences.count > 0 else {
            return (fieldName, info)
        }
        
        if tempResult.inferences.count > 0 {
            let inference = tempResult.inferences[position]
            fieldName = inference.label
            info =  String(format: "%.2f", inference.confidence * 100.0) + "%"
        }
        else {
            fieldName = ""
            info = ""
        }
        
        return (fieldName, info)
    }
    
    @IBAction func confirmObjectSelection(_ sender: UIButton) {
        guard let object = resultTuple?.name else { return } // TODO: - Deal with error
        Database.updateObject(object)
        delegate?.didScanObject()
    }
    
    func turnAlarmOff() {
        
        AppDelegate.audioPlayer.stopAlarmSound()
        print("found the object")
        
        delegate?.didScanObject()
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? ResultTableViewCell
        var fieldName = ""
        var info = ""
        
        let tuple = displayStringsForResults(position: indexPath.row)
        resultTuple = tuple
        
        fieldName = tuple.name
        info = tuple.precision

        cell?.itemName.text = fieldName
        cell?.itemAccuracy.text = info
        
        if !isRegisteringObject {
            guard let objectSaved = Database.getObject() else {
                return cell ?? UITableViewCell()
            }
            
            if tuple.name == objectSaved {
                turnAlarmOff()
            }
        }
        
        return cell ?? UITableViewCell()

    }
    


    
    
}
