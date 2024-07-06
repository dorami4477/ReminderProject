//
//  DeadlineViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

final class DeadlineViewController: BaseViewController {

    private var selectedDate:Int = GetDate.shared.todayInt
    private let mainView = DeadlineView()
    var deadLine:((Int) -> Void)?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

