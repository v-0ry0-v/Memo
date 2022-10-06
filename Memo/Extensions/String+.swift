//
//  String+.swift
//  Memo
//
//  Created by Ryoya Ogura on 2022/10/07.
//

import Foundation

extension String {
    var replaceNewlineWithSpace: String {
        return self.replacingOccurrences(of: "\n", with: " ")
    }
}
