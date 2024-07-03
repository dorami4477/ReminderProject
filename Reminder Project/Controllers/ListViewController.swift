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
    
    var list:Results<Todo>!{
        didSet{
            filteredList = list
        }
    }
    var filteredList:Results<Todo>!
    let realm = try! Realm()
    var rightBarButtonItem = UIBarButtonItem()
    var sortedBy: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureTableView()

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
        let back = UIBarButtonItem(image:UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = back
        let more = UIBarButtonItem(image:UIImage(systemName: "ellipsis.circle") ,menu: createMenu())
        navigationItem.rightBarButtonItem = more
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableCell.self, forCellReuseIdentifier: ListTableCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func moreButtonTapped(){
        
    }

    //*필터 정리 필요!
    private func createMenu(actionTitle: String? = nil) -> UIMenu {
        let menu = UIMenu(title: "Sorted by", children: [
            UIAction(title: "마감일 순") { [unowned self] action in
                self.rightBarButtonItem.menu = createMenu(actionTitle: action.title)
                sortedBy = 1
                arragingData(title: action.title)
                tableView.reloadData()
            },
            UIAction(title: "제목 순") { [unowned self] action in
                self.rightBarButtonItem.menu = createMenu(actionTitle: action.title)
                sortedBy = 2
                arragingData(title: action.title)
                tableView.reloadData()
            },
            UIAction(title: "우선순위 순") { [unowned self] action in
                self.rightBarButtonItem.menu = createMenu(actionTitle: action.title)
                sortedBy = 3
                arragingData(title: action.title)
                print(action.title, action.state == .on)
                tableView.reloadData()
            }
        ])
        
        if let actionTitle = actionTitle {
            menu.children.forEach { action in
                guard let action = action as? UIAction else {
                    return
                }
                if action.title == actionTitle {
                    action.state = .on
                }
            }
        } else {
            let action = menu.children.first as? UIAction
            action?.state = .on
        }
        
        return menu
    }
    
    func arragingData(title: String){
        if title == "마감일 순"{
            filteredList = list
        }else if title == "제목 순"{
            filteredList = list.sorted(byKeyPath: "title", ascending: true)
        }else if title == "우선순위 순"{
            filteredList = list.sorted(byKeyPath: "priority", ascending: false)
        }
    }
}

extension ListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.identifier, for: indexPath) as! ListTableCell
        cell.data = filteredList[indexPath.row]
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


