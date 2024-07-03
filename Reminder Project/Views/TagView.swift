//
//  TagView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class TagView: BaseView {

    let textField = {
        let textField = UITextField()
        textField.placeholder = "태그를 입력하세요."
        return textField
    }()
    
    
    override func configureHierarchy() {
        addSubview(textField)
    }
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
