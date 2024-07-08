//
//  NewFolderViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/8/24.
//

import UIKit

class NewFolderViewController: BaseViewController {

    private let repository = TodoRepository()
    private lazy var folderList = repository.fetchFolder()
    private let mainView = FolderView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        if folderList.count == 0{
            repository.setInitialFolderList()
        }
    }
    
    override func configureView() {
        navigationItem.title = "전체"
        navigationController?.navigationBar.prefersLargeTitles = true
        let calender = UIBarButtonItem(image:UIImage(systemName: Icon.calendar), style: .plain, target: self, action: #selector(calenderButtonTapped))
        navigationItem.rightBarButtonItem = calender
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    private func configureCollectionView(){
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(NewFolderCollectionCell.self, forCellWithReuseIdentifier: NewFolderCollectionCell.identifier)
    }
    
    @objc private func addButtonTapped(){
        let addVC = NewAddViewController()
        addVC.delegate = self
        let nav = UINavigationController(rootViewController: addVC)
        present(nav, animated:true)
    }
    
    @objc private func calenderButtonTapped(){
        print(#function)
        let vc = CalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - collectionView
extension NewFolderViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewFolderCollectionCell.identifier, for: indexPath) as! NewFolderCollectionCell
        //folderList[indexPath.row].count = repository.setFolderData(indexPath.row, date: nil).count
        cell.data = folderList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NewListViewController()
        vc.delegate = self
        vc.folder = folderList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension NewFolderViewController:NewAddTodoDelegate{
    func addTodo(data: NewTodo, folder: NewFolder) {
        repository.addNewTodo(data: data, folder: folder)
        mainView.collectionView.reloadData()
    }
}

extension NewFolderViewController:NewChangeDateDelegate{
    func updateData(data:Todo, cellName:String, value:Bool) {
        repository.updateCell(id: data.id, cellName: cellName, cellValue: value)
        mainView.collectionView.reloadData()
    }
    
    func deleteData(data:NewTodo){
        repository.deleteNewTodo(dataID: data.id)
        mainView.collectionView.reloadData()
    }
}
