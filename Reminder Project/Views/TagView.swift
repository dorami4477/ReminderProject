//
//  TagView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

final class TagView: BaseView {

    let backButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let textField = {
        let textField = UITextField()
        textField.placeholder = "태그를 입력하세요."
        return textField
    }()
    
    
    override func configureHierarchy() {
        addSubview(backButton)
        addSubview(textField)
    }
    override func configureLayout() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(25)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }

}
