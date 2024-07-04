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
        let more = UIBarButtonItem(image:UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(moreButtonTapped))
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
        let alert = UIAlertController(title: "Sorted by", message: nil, preferredStyle: .actionSheet)
            
        let button1 = UIAlertAction(title: "마감일 순", style: .default){ _ in
            self.arragingData(sort: 0)
            self.tableView.reloadData()
        }
        let button2 = UIAlertAction(title: "제목 순", style: .default){ _ in
            self.arragingData(sort: 1)
            self.tableView.reloadData()
        }
        let button3 = UIAlertAction(title: "우선순위 순", style: .default){ _ in
            self.arragingData(sort: 2)
            self.tableView.reloadData()
        }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(button1)
            alert.addAction(button2)
            alert.addAction(button3)
            alert.addAction(cancel)
            
            present(alert, animated: true)
    }

    func arragingData(sort: Int){
        switch sort{
        case 0:
            filteredList = list
        case 1:
            filteredList = list.sorted(byKeyPath: "title", ascending: true)
        case 2:
            filteredList = list.sorted(byKeyPath: "priority", ascending: true)
        default:
            filteredList = list
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let data = self.realm.object(ofType: Todo.self, forPrimaryKey: self.filteredList[indexPath.row].id)!
        //스와이프 삭제
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            self.showAlert(title: "삭제", message: "정말로 삭제 하시겠습니까?", buttonTitle: "삭제") {
                try! self.realm.write {
                    self.realm.delete(data)
                }
                tableView.reloadData()
            }
        }
        //스와이프 핀고정
        let pinned = UIContextualAction(style: .normal, title: "핀고정") { action, view, completionHandler in
            let pinned = !data.pinned
            try! self.realm.write {
                self.realm.create(Todo.self, value: ["id":data.id, "pinned": pinned], update: .modified)
            }
            completionHandler(true)
        }
        
        delete.backgroundColor = AppColor.red
        pinned.backgroundColor = AppColor.yellow
        delete.image = UIImage(systemName:Icon.delete)
        pinned.image = data.pinned ? UIImage(systemName:Icon.pinned) : UIImage(systemName:Icon.unpinned)
        return UISwipeActionsConfiguration(actions: [delete, pinned])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //완료 체크
        let data = filteredList[indexPath.row]
        let complete = !data.completed
        let cell = tableView.cellForRow(at: indexPath) as! ListTableCell
        cell.checkButtonTapped(complete)
        
        try! realm.write {
            realm.create(Todo.self, value: ["id":data.id, "completed": complete], update: .modified)
        }
    }

}


