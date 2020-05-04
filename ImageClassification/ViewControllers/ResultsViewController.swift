//
//  ResultsViewController.swift
//  ImageClassification
//
//  Created by Guilherme Piccoli on 30/04/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var inferenceResult: Result? = nil
    @IBOutlet weak var resultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        let info = displayStringsForResults(position: 0)
        print(info)
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
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? ResultTableViewCell
        cell?.itemName.text = "alo"
        cell?.itemAccuracy.text = "100%"
        
        var fieldName = ""
        var info = ""
        
        let tuple = displayStringsForResults(position: indexPath.row)
        fieldName = tuple.name
        info = tuple.precision

            
        cell?.itemName.text = fieldName
        cell?.itemAccuracy.text = info
        return cell ?? UITableViewCell()
        
    }
    


    
    
}
