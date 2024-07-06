//
//  PriorityView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class PriorityView: BaseView {

    let backButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        return button
    }()
    let segment = {
        let seg = UISegmentedControl(items: ["High", "Middle", "Low"])
        seg.selectedSegmentIndex = 2
        return seg
    }()
    
    override func configureHierarchy() {
        addSubview(backButton)
        addSubview(segment)
    }
    override func configureLayout() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(25)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        segment.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
