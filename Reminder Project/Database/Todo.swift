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
    @Persisted var registerDate: String
    @Persisted var memoTag: String?
    @Persisted var priority: Int
    @Persisted var complete: Bool
    
    convenience init(title: String, content: String? = nil, registerDate: String, memoTag: String? = nil, priority: Int = 2, complete:Bool = false) {
        self.init()
        self.id = id
        self.title = title
        self.content = content
        self.registerDate = registerDate
        self.memoTag = memoTag
        self.priority = priority
        self.complete = complete
    }
}
