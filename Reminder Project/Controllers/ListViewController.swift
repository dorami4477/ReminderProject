//
//  ViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit
import SnapKit

protocol ChangeDateDelegate:AnyObject {
    func updateData(data:Todo, cellName:String, value:Bool)
    func deleteData(data:Todo)
}

final class ListViewController: BaseViewController {

    private let tableView = UITableView()
    let repository = TodoRepository()
    var list:[Todo] = []
    weak var delegate:ChangeDateDelegate?
    var folderInfo:[String:Int] = [:]
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
    
    @objc private func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func moreButtonTapped(){
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


    func arragingData(sort:Int){
        switch sort{
        case 0:
            list.sort{ $0.registerDate < $1.registerDate }
        case 1:
            list.sort{ $0.title < $1.title }
        case 2:
            list.sort{ $0.priority < $1.priority }
        default:
            list.sort{ $0.registerDate < $1.registerDate }
        }
    }

}

extension ListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.identifier, for: indexPath) as! ListTableCell
        cell.data = list[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let data = self.list[indexPath.row]
        
        //스와이프 핀고정
        let pinned = UIContextualAction(style: .normal, title: "핀고정") { action, view, completionHandler in
            let pinValue = !data.pinned
            self.delegate?.updateData(data: data, cellName: "pinned", value:pinValue)
            completionHandler(true)
        }
        pinned.backgroundColor = AppColor.yellow
        pinned.image = data.pinned ? UIImage(systemName:Icon.pinned) : UIImage(systemName:Icon.unpinned)
        
        //스와이프 삭제
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            self.showAlert(title: "삭제", message: "정말로 삭제 하시겠습니까?", buttonTitle: "삭제") {
                ImageFileManager.shared.removeImageFromDocument(filename: "\(data.id)")
                self.delegate?.deleteData(data: data)
                self.list = self.repository.setFolderData(self.folderInfo["folderNumber"] ?? 2, date: self.folderInfo["date"])
                tableView.reloadData()
            }
        }
        delete.backgroundColor = AppColor.red
        delete.image = UIImage(systemName:Icon.delete)
        return UISwipeActionsConfiguration(actions: [delete, pinned])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //완료 체크
        let data = list[indexPath.row]
        let complete = !data.completed
        let cell = tableView.cellForRow(at: indexPath) as! ListTableCell
        cell.checkButtonTapped(complete)
        self.delegate?.updateData(data: data, cellName: "completed", value:complete)
    }
    

}


