//
//  FolderCollectionCell.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class FolderCollectionCell: UICollectionViewCell {
    var data:Folder = Folder(icon: "", title: "", count: 0, color: .black){
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
            make.height.width.equalTo(25)
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
        backgroundColor = .lightGray
        self.layer.cornerRadius = 20
        iconImageView.tintColor = .white
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .gray
        countLabel.font = .boldSystemFont(ofSize: 20)
        iconView.layer.cornerRadius = 12.5
        iconView.clipsToBounds = true
    }
    
    private func configureData(){
        iconImageView.image = UIImage(systemName: data.icon)
        titleLabel.text = data.title
        countLabel.text = data.count.formatted()
        iconView.backgroundColor = data.color

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
