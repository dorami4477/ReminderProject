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
    
    let deadlineButtonView = TodoButtonView(title: "마감일")
    let tagButtonView = TodoButtonView(title: "태그")
    let priorityButtonView = TodoButtonView(title: "우선순위")
    let imageButtonView = TodoButtonView(title: "이미지 추가")
    
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    
    override func configureHierarchy() {
        addSubview(titleTextField)
        addSubview(contentTextView)
        addSubview(deadlineButtonView)
        addSubview(tagButtonView)
        addSubview(priorityButtonView)
        addSubview(imageButtonView)
        imageButtonView.addSubview(imageView)
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
            make.height.equalTo(48)
        }
        tagButtonView.snp.makeConstraints { make in
            make.top.equalTo(deadlineButtonView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(48)
        }
        priorityButtonView.snp.makeConstraints { make in
            make.top.equalTo(tagButtonView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(48)
        }
        imageButtonView.snp.makeConstraints { make in
            make.top.equalTo(priorityButtonView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(48)
        }
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.trailing.equalTo(imageButtonView.contentLabel.snp.trailing)
            make.centerY.equalToSuperview()
        }
    }
    

    
    override func configureView() {
        deadlineButtonView.contentLabel.text = GetDate.shared.getToday()
        priorityButtonView.contentLabel.text = "Low"
    }
    
}
