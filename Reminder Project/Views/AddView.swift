//
//  AddView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit

final class AddView: BaseView {

    let titleTextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.00)
        return textField
    }()
    let contentTextView = {
        let textView = UITextView()
        textView.text = "메모"
        textView.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.00)
        return textView
    }()
    let deadLineTextField = {
        let textField = UITextField()
        textField.placeholder = "마감일"
        textField.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.00)
        return textField
    }()

    
    override func configureHierarchy() {
        addSubview(titleTextField)
        addSubview(contentTextView)
        addSubview(deadLineTextField)
    }
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(44)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(88)
        }
        deadLineTextField.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(44)
        }
        
    }
}
