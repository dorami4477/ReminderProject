//
//  NewListViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/8/24.
//

import UIKit
import SnapKit

protocol NewChangeDateDelegate:AnyObject {
    func updateData(data:Todo, cellName:String, value:Bool)
    func deleteData(data:NewTodo)
}

final class NewListViewController: BaseViewController {

    private let tableView = UITableView()
    let repository = TodoRepository()
    lazy var list:[NewTodo] = Array(folder.todoList)
    weak var delegate:NewChangeDateDelegate?
    var folder:NewFolder = NewFolder(icon: "", title: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if list.count == 0{
            showAlert(title: "할일 목록이 없습니다!", message: "할일을 등록 후 조회해주세요:)", buttonTitle: "확인") {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
        navigationController?.navigationBar.prefersLargeTitles = false
        if folder.title == "전체"{
            let searchCon = UISearchController(searchResultsController: nil)
            searchCon.searchBar.placeholder = "할 일을 검색하세요."
            self.navigationItem.searchController = searchCon
            self.navigationController?.navigationBar.shadowImage = nil
            searchCon.searchBar.autocapitalizationType = .none
            searchCon.searchBar.autocorrectionType = .no
            searchCon.searchBar.delegate = self
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        title = folder.title
        let back = UIBarButtonItem(image:UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = back

    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewListTableCell.self, forCellReuseIdentifier: NewListTableCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    @objc private func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    

}

extension NewListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewListTableCell.identifier, for: indexPath) as! NewListTableCell
        cell.data = list[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let data = self.list[indexPath.row]
        
        //스와이프 삭제
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            self.showAlert(title: "삭제", message: "정말로 삭제 하시겠습니까?", buttonTitle: "삭제") {
                ImageFileManager.shared.removeImageFromDocument(filename: "\(data.id)")
                self.delegate?.deleteData(data: data)
                let list = self.repository.findFolderWithTitle(self.folder.title).todoList
                self.list = Array(list)
                tableView.reloadData()
            }
        }
        delete.backgroundColor = AppColor.red
        delete.image = UIImage(systemName:Icon.delete)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //완료 체크
        let data = list[indexPath.row]
        let complete = !data.completed
        let cell = tableView.cellForRow(at: indexPath) as! NewListTableCell
        cell.checkButtonTapped(complete)
      //  self.delegate?.updateData(data: data, cellName: "completed", value:complete)
    }
    

}

extension NewListViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        list = list.filter{$0.title.lowercased().contains(searchText.lowercased())}
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let list = self.repository.findFolderWithTitle(self.folder.title).todoList
        self.list = Array(list)
        tableView.reloadData()
    }
}
