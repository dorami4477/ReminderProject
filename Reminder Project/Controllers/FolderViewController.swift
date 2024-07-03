//
//  FolderViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit
import RealmSwift

final class FolderViewController: BaseViewController {

    var todoList:Results<Todo>!
    let realm = try! Realm()
    
    var list = FolderData.shared.Folderlists
    var folder1:Results<Todo>!
    var folder2:Results<Todo>!
    
    let mainView = FolderView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setData()
        navigationItem.title = "title"
    }
    
    override func configureView() {
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    private func configureCollectionView(){
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(FolderCollectionCell.self, forCellWithReuseIdentifier: FolderCollectionCell.identifier)
    }
    
    @objc func addButtonTapped(){
        let addVC = AddViewController()
        addVC.delegate = self
        let nav = UINavigationController(rootViewController: addVC)
        present(nav, animated:true)
    }
    
    func setData(){
        todoList = realm.objects(Todo.self).sorted(byKeyPath: "registerDate", ascending: false)
        //오늘
        let today = getToday()
        folder1 = todoList.where { $0.registerDate == today}.sorted(byKeyPath: "registerDate", ascending: false)
        folder2 = todoList.where { $0.registerDate != today}.sorted(byKeyPath: "registerDate", ascending: false)
        list[0].count = folder1.count
        list[1].count = folder2.count
        list[2].count = todoList.count
        
    }
    
    func getToday() -> String{
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyy. MM. dd"
            let dateString = myFormatter.string(from: Date())
            return dateString
        }
}

extension FolderViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCollectionCell.identifier, for: indexPath) as! FolderCollectionCell
        cell.data = list[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ListViewController()
        switch indexPath.row{
            case 0:
            vc.list = folder1
        case 1:
            vc.list = folder2
        default:
            vc.list = todoList
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension FolderViewController:AddTodoDelegate{
    func addTodo(data:Todo) {
        try! self.realm.write {
            self.realm.add(data)
        }
        setData()
        mainView.collectionView.reloadData()
    }
    
}
