//
//  DeadlineViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class DeadlineViewController: BaseViewController {

    var selectedDate:Int = GetDate.shared.todayInt
    
    private let mainView = DeadlineView()
    
    var deadLine:((Int) -> Void)?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.picker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        mainView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deadLine?(selectedDate)
    }

    @objc func setDate(_ sender: UIDatePicker){
        selectedDate = dateFormat(date: sender.date)
    }
    
    @objc func backButtonTapped(){
        dismiss(animated: true)
    }

    private func dateFormat(date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return Int(formatter.string(from: date))!
    }

}

