//
//  UIAlertController+.swift
//  Memo
//
//  Created by Ryoya Ogura on 2022/10/07.
//

import UIKit

extension UIAlertController {
    func addActions(_ actions: [UIAlertAction]) {
        for action in actions {
            self.addAction(action)
        }
    }
}
