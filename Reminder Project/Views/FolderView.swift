//
//  FolderView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class FolderView: BaseView {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let addButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setTitle("새로운 할 일", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(addButton)
    }
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(addButton.snp.top).inset(10)
        }
        addButton.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
        }
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
