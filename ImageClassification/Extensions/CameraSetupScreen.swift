//
//  CameraSetupScreen.swift
//  ImageClassification
//
//  Created by Rafael Ferreira on 06/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

class CameraSetupScreen: UIViewController {
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var instructionsLabel: UILabel!

    
    override func viewDidLoad() {
        card.layer.cornerRadius = 10
        instructionsLabel.attributedText = NSMutableAttributedString()
        .normal("Create an object ", 18)
        .bold("far from your room ", 18)
        .normal("to find when turning off the alarm clock and point your camera at it", 18)
    }
}
