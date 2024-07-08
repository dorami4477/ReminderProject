//
//  NewFolderCollectionCell.swift
//  Reminder Project
//
//  Created by 박다현 on 7/8/24.
//

import UIKit

final class NewFolderCollectionCell: UICollectionViewCell {
    var data:NewFolder = NewFolder(icon: "", title: ""){
        didSet{
            configureData()
        }
    }
    let iconView = UIView()
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    


    private func configureHierarchy(){
        contentView.addSubview(iconView)
        iconView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
    }
    private func configureLayout(){
        iconView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(30)
        }
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(3)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(15)
        }
        countLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
        }
    }
    private func configureUI(){
        backgroundColor = AppColor.ground
        self.layer.cornerRadius = 15
        iconImageView.tintColor = .white
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .gray
        countLabel.font = .boldSystemFont(ofSize: 25)
        iconView.layer.cornerRadius = 15
        iconView.clipsToBounds = true
    }
    
    private func configureData(){
        iconImageView.image = UIImage(systemName: data.icon)
        titleLabel.text = data.title
        countLabel.text = data.todoList.count.formatted()
        iconView.backgroundColor = .brown

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
