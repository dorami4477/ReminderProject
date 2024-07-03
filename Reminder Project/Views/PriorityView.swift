//
//  PriorityView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class PriorityView: BaseView {

    let segment = {
        let seg = UISegmentedControl(items: ["High", "Middle", "Low"])
        seg.selectedSegmentIndex = 2
        return seg
    }()
    
    override func configureHierarchy() {
        addSubview(segment)
    }
    override func configureLayout() {
        segment.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
