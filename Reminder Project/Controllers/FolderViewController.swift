//
//  FolderViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

final class FolderViewController: BaseViewController {

    let list = FolderData.shared.Folderlists
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        navigationItem.title = "title"
    }
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FolderCollectionCell.self, forCellWithReuseIdentifier: FolderCollectionCell.identifier)
    }
    
    private func layout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = (UIScreen.main.bounds.width - 30) / 2
        layout.itemSize = CGSize(width: width, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
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
        navigationController?.pushViewController(vc, animated: true)
    }
}
