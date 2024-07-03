//
//  DeadlineView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class DeadlineView: BaseView {

    let picker = {
        let picker = UIPickerView()
        picker.backgroundColor = AppColor.button
        return picker
    }()

    override func configureHierarchy() {
        addSubview(picker)
    }
    override func configureLayout() {
        picker.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}

