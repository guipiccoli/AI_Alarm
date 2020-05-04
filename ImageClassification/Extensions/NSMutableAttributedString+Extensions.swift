//
//  NSMutableAttributedString+Extensions.swift
//  ImageClassification
//
//  Created by Rafael Ferreira on 04/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func bold(_ value:String, _ size:CGFloat) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.boldSystemFont(ofSize: size),
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String, _ size:CGFloat) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: size)
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
