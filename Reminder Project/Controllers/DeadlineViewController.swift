//
//  DeadlineViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

final class DeadlineViewController: BaseViewController {

    var selectedDate:Int = 0
    let mainView = DeadlineView()
    var deadLine:((Int) -> Void)?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = GetDate.shared.toDate(date: "\(selectedDate)") ?? Date()
        mainView.picker.setDate(date, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deadLine?(selectedDate)
    }
    
    override func configureView() {
        mainView.picker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc private func setDate(_ sender: UIDatePicker){
        selectedDate = GetDate.shared.dateToInt(date: sender.date)
    }
    
    @objc private func backButtonTapped(){
        dismiss(animated: true)
    }
    
    
}

