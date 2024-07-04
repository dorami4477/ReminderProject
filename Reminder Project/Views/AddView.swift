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
        textField.backgroundColor = AppColor.ground
        return textField
    }()
    let contentTextView = {
        let textView = UITextView()
        textView.text = "메모"
        textView.backgroundColor = AppColor.ground
        return textView
    }()
    
    //마감일
    let deadlineButtonView = TodoButtonView(title: "마감일")
    let tagButtonView = TodoButtonView(title: "태그")
    let priorityButtonView = TodoButtonView(title: "우선순위")

    
    override func configureHierarchy() {
        addSubview(titleTextField)
        addSubview(contentTextView)
        addSubview(deadlineButtonView)
        addSubview(tagButtonView)
        addSubview(priorityButtonView)
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
        deadlineButtonView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(44)
        }
        tagButtonView.snp.makeConstraints { make in
            make.top.equalTo(deadlineButtonView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(44)
        }
        priorityButtonView.snp.makeConstraints { make in
            make.top.equalTo(tagButtonView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(44)
        }
    }
    
    func getToday() -> String{
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyy. MM. dd"
            let savedDateString = myFormatter.string(from: Date())
            return savedDateString
    }
    
    override func configureView() {
        deadlineButtonView.contentLabel.text = getToday()
        priorityButtonView.contentLabel.text = "Low"
    }
    
}
