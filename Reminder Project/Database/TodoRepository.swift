//
//  TodoRepository.swift
//  Reminder Project
//
//  Created by 박다현 on 7/5/24.
//

import Foundation
import RealmSwift

class TodoRepository{
    let realm = try! Realm()
    
    func fetchAll() -> [Todo]{
        let todoList = realm.objects(Todo.self).sorted(byKeyPath: "registerDate", ascending: true)
        print(realm.configuration.fileURL!)
        return Array(todoList)
        
    }
    
    //Create
    func addTodo(data:Todo) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    //Delete
    func deleteTodo(dataID: ObjectId) {
        let data = self.realm.object(ofType: Todo.self, forPrimaryKey: dataID)!
        try! self.realm.write {
            self.realm.delete(data)
        }
    }
    
    //Update
    func updateCell(id: ObjectId, cellName:String, cellValue:Bool){
        try! self.realm.write {
            self.realm.create(Todo.self, value: ["id":id, cellName: cellValue], update: .modified)
        }
    }
    
    //Read
    func setFolderData(_ folder:Int) -> [Todo]{
        var list:Results<Todo>!
        switch folder{
        case 0:
            list = realm.objects(Todo.self).where { $0.registerDate == GetDate.shared.todayInt }.sorted(byKeyPath: "registerDate", ascending: true)
        case 1:
            list = realm.objects(Todo.self).where { $0.registerDate > GetDate.shared.todayInt }.sorted(byKeyPath: "registerDate", ascending: true)
        case 2:
            list = realm.objects(Todo.self).sorted(byKeyPath: "registerDate", ascending: true)
        case 3:
            list = realm.objects(Todo.self).where { $0.pinned == true }.sorted(byKeyPath: "registerDate", ascending: true)
        case 4:
            list = realm.objects(Todo.self).where { $0.completed == true }.sorted(byKeyPath: "registerDate", ascending: true)
        default:
            list = realm.objects(Todo.self)
        }
        return Array(list)
    }
    
    

}
