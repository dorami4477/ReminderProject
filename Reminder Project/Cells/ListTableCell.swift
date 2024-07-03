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
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override func configureHierarchy(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
    }
    override func configureLayout(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    override func configureView(){
        
    }
    
    func configureData(){
        titleLabel.text = data?.title
        contentLabel.text = data?.content
        dateLabel.text = data?.registerDate
        guard let data = data, let tag = data.memoTag else { return }
        tagLabel.text = "#\(tag)"
    }
}
