//
//  DeadlineView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

final class DeadlineView: BaseView {

    let backButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let picker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko-KR")
        picker.backgroundColor = AppColor.ground
        return picker
    }()

    override func configureHierarchy() {
        addSubview(backButton)
        addSubview(picker)
    }
    override func configureLayout() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(25)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        picker.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}

