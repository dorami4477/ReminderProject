//
//  Todo.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var registerDate: String?
    
    convenience init(title: String, content: String?, registerDate: String?) {
        self.init()
        self.title = title
        self.content = content
        self.registerDate = registerDate
    }
}
