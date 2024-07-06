//
//  Todo.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import Foundation
import RealmSwift

final class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var registerDate: Int
    @Persisted var memoTag: String?
    @Persisted var priority: Int
    @Persisted var completed: Bool
    @Persisted var pinned: Bool
    

    convenience init(title: String, content: String? = nil, registerDate: Int, memoTag: String? = nil, priority: Int = 2, complete:Bool = false, pinned:Bool = false) {
        self.init()
        self.id = id
        self.title = title
        self.content = content
        self.registerDate = registerDate
        self.memoTag = memoTag
        self.priority = priority
        self.completed = complete
        self.pinned = pinned
    }
}
