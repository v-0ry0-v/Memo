//
//  Date+.swift
//  Memo
//
//  Created by Ryoya Ogura on 2022/10/07.
//

import Foundation

extension Date {
    func toFormatString(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
