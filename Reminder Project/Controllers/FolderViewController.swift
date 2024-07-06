//
//  FolderViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

final class FolderViewController: BaseViewController {

    private let repository = TodoRepository()
    private var folderList = FolderData.shared.Folderlists
    private let mainView = FolderView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()

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
        mainView.collectionView.register(FolderCollectionCell.self, forCellWithReuseIdentifier: FolderCollectionCell.identifier)
    }
    
    @objc private func addButtonTapped(){
        let addVC = AddViewController()
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

extension FolderViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCollectionCell.identifier, for: indexPath) as! FolderCollectionCell
        folderList[indexPath.row].count = repository.setFolderData(indexPath.row, date: nil).count
        cell.data = folderList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ListViewController()
        vc.delegate = self
        vc.list = repository.setFolderData(indexPath.row, date: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension FolderViewController:AddTodoDelegate{
    
    func addTodo(data:Todo) {
        repository.addTodo(data: data)
        mainView.collectionView.reloadData()
    }
}

extension FolderViewController:ChangeDateDelegate{
    func updateData(data:Todo, cellName:String, value:Bool) {
        repository.updateCell(id: data.id, cellName: cellName, cellValue: value)
        mainView.collectionView.reloadData()
    }
    
}
