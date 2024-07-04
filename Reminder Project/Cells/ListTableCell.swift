//
//  ListTableCell.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit

final class ListTableCell: BaseTableCell {
    
    var data: Todo?{
        didSet{
            configureData()
        }
    }
    
    let checkImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    private let titleLabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    private let contentLabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    private let dateLabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    private let tagLabel = {
        let label = UILabel()
        label.textColor = AppColor.blue
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override func configureHierarchy(){
        contentView.addSubview(checkImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
    }
    override func configureLayout(){
        checkImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(25)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalTo(checkImageView.snp.trailing).offset(15)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(checkImageView.snp.trailing).offset(15)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.leading.equalTo(checkImageView.snp.trailing).offset(15)
        }
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalTo(checkImageView.snp.trailing).offset(15)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    override func configureView(){
        
    }
    
    func configureData(){
        guard let data else { return }
        contentLabel.text = data.content
        dateLabel.text = data.registerDate
        tagLabel.text = (data.memoTag != nil) ? "#\(data.memoTag!)" : ""
        
        switch data.priority{
        case 0:
            titleLabel.text = "!!! " + data.title
        case 1:
            titleLabel.text = "!! " + data.title
        case 2:
            titleLabel.text = "! " + data.title
        default:
            titleLabel.text = "! " + data.title
        }
        
        checkButtonTapped(data.completed)
    }
    
    func checkButtonTapped(_ complete:Bool){
        if complete{
            checkImageView.image = UIImage(systemName: Icon.completed)
            titleLabel.attributedText = titleLabel.text?.strikeThrough()
        }else{
            checkImageView.image = UIImage(systemName: Icon.incomplete)
            titleLabel.attributedText = titleLabel.text?.removeStrikeThrough()
        }
    }

}
