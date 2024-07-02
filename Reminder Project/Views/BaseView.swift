//
//  BaseView.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit


class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        configureHierarchy()
        configureLayout()
        configureView()
    }
    

    func configureHierarchy(){}
    func configureLayout(){}
    func configureView(){}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
