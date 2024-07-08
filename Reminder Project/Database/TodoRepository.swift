//
//  TodoRepository.swift
//  Reminder Project
//
//  Created by 박다현 on 7/5/24.
//

import Foundation
import RealmSwift

final class TodoRepository{
    private let realm = try! Realm()
    
    //Create
    func addTodo(data:Todo) {
        
        try! realm.write {
            realm.add(data)
        }
    }
    
    //Delete
    func deleteTodo(dataID: ObjectId) {
        let data = realm.object(ofType: Todo.self, forPrimaryKey: dataID)!
        try! realm.write {
            realm.delete(data)
        }
    }
    
    //Update
    func updateCell(id: ObjectId, cellName:String, cellValue:Bool){
        try! realm.write {
            realm.create(Todo.self, value: ["id":id, cellName: cellValue], update: .modified)
        }
    }
    
    //Read
    func setFolderData(_ folder:Int, date:Int?) -> [Todo]{
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
        case 5:
            list = realm.objects(Todo.self).where { $0.registerDate == date ?? 0}.sorted(byKeyPath: "completed", ascending: true)
        default:
            list = realm.objects(Todo.self)
        }
        return Array(list)
    }
    
    //print(realm.configuration.fileURL!)
    
    
    //---------------NewTodo --------
    
    func fetchFolder() -> [NewFolder]{
        let value = realm.objects(NewFolder.self)
        return Array(value)
    }
    
    //초기 폴더 리스트 세팅
    func setInitialFolderList(){
        print(realm.configuration.fileURL!)
        let list = [
            NewFolder(icon: "calendar", title: "오늘"),
            NewFolder(icon: "calendar.badge.clock", title: "예정"),
            NewFolder(icon: "tray.full.fill", title: "전체"),
            NewFolder(icon: "flag.fill", title: "깃발 표시"),
            NewFolder(icon: "checkmark", title: "완료됨")
        ]
        do {
            try realm.write {
                realm.add(list)
            }
        } catch {
            print("faild to set the folder List")
        }
    } 
    
    func addNewTodo(data:NewTodo, folder:NewFolder) {
        try! realm.write {
            folder.todoList.append(data)
        }
    }
    
    
    func findFolder(date:Int) -> NewFolder{
        if date == GetDate.shared.todayInt{
            return realm.objects(NewFolder.self).where{ $0.title == "오늘"}.first ?? NewFolder()
        }else if date > GetDate.shared.todayInt{
            return realm.objects(NewFolder.self).where{ $0.title == "예정"}.first ?? NewFolder()
        }else{
            return realm.objects(NewFolder.self).where{ $0.title == "전체"}.first ?? NewFolder()
        }
    }

}
