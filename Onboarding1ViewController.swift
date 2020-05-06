//
//  Onboarding1.swift
//  ImageClassification
//
//  Created by Rafael Ferreira on 04/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

class Onboarding1: UIViewController {
    @IBOutlet weak var startingMessage: UILabel!
    
    override func viewDidLoad() {
        startingMessage.attributedText = NSMutableAttributedString()
            .normal("We are going to make you ", 24)
            .bold("get up", 24)
            .normal("!", 24)
    }
}
