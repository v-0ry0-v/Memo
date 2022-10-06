//
//  Memo.swift
//  Memo
//
//  Created by Ryoya Ogura on 2022/10/07.
//

import Foundation
import RealmSwift

class Memo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var text = ""
    @Persisted var updatedAt = Date()
    
    func changeText(text: String) {
        self.text = text
        self.updatedAt = Date()
    }
}
