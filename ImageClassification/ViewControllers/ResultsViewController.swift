//
//  ResultsViewController.swift
//  ImageClassification
//
//  Created by Guilherme Piccoli on 30/04/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var precisionLabel: UILabel!
    
    var inferenceResult: Result? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let info = displayStringsForResults(position: 0)
        itemLabel.text = info.name
        precisionLabel.text = info.precision
        
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
