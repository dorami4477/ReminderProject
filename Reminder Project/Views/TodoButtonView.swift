//
//  TodoButtonView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class TodoButtonView: BaseView {

    let buttonView = {
        let view = UIView()
        view.backgroundColor = AppColor.ground
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    let titleLabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let contentLabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    let iconImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.right")
        img.tintColor = .white
        return img
    }()
    
    init(title:String) {
        super.init(frame: .zero)
        titleLabel.text = title
    }
    
    override func configureHierarchy() {
        addSubview(buttonView)
        buttonView.addSubview(titleLabel)
        buttonView.addSubview(contentLabel)
        buttonView.addSubview(iconImageView)
    }
    
    override func configureLayout() {
        buttonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        contentLabel.snp.makeConstraints { make in
            make.trailing.equalTo(iconImageView.snp.leading).offset(-15)
            make.centerY.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
    }

}
