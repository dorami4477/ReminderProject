//
//  NewTodo.swift
//  Reminder Project
//
//  Created by 박다현 on 7/8/24.
//

import Foundation
import RealmSwift

final class NewFolder: Object{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var icon:String
    @Persisted var title:String
    @Persisted var regDate: Date
    @Persisted var todoList:List<NewTodo>
    
    convenience init(icon: String, title: String) {
        self.init()
        self.id = id
        self.icon = icon
        self.title = title
        self.regDate = Date()
    }
}


final class NewTodo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var content: String?
    @Persisted var registerDate: Int
    @Persisted var memoTag: String?
    @Persisted var priority: Int
    @Persisted var completed: Bool
    @Persisted var pinned: Bool

    @Persisted(originProperty: "todoList") var main:LinkingObjects<NewFolder>
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
