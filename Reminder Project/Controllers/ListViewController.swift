//
//  ViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift


final class ListViewController: BaseViewController {

    private let tableView = UITableView()
    
    var list:Results<Todo>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureTableView()
        configureData()
    }
    override func configureHierarchy() {
        view.addSubview(tableView)
    }

    override func configureLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        title = "전체"
        let add = UIBarButtonItem(title:"add", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = add
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableCell.self, forCellReuseIdentifier: ListTableCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .black
    }
    private func configureData(){
        list = realm.objects(Todo.self)
    }
    
    @objc func addButtonTapped(){
        let addVC = AddViewController()
        addVC.delegate = self
        let nav = UINavigationController(rootViewController: addVC)
        present(nav, animated:true)
    }
}

extension ListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.identifier, for: indexPath) as! ListTableCell
        cell.data = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
           
            self.showAlert(title: "삭제", message: "정말로 삭제 하시겠습니까?", buttonTitle: "삭제") {
                let data = self.realm.object(ofType: Todo.self, forPrimaryKey: self.list[indexPath.row].id)!
                try! self.realm.write {
                    self.realm.delete(data)
                }
                tableView.reloadData()
            }
        }
        
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }

}

extension ListViewController:AddTodoDelegate{
    func addTodo(data:Todo) {
        try! self.realm.write {
            self.realm.add(data)
        }
        tableView.reloadData()
    }
    
    
}
