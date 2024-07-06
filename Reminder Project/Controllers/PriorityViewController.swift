//
//  PriorityViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

final class PriorityViewController: BaseViewController {

    private let mainView = PriorityView()
    
    var priorityValue:((Int) -> Void)?
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    override func viewWillDisappear(_ animated: Bool) {
        priorityValue?(mainView.segment.selectedSegmentIndex)
    }

    @objc func backButtonTapped(){
        dismiss(animated: true)
    }

}
