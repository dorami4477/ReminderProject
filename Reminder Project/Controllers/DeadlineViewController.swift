//
//  DeadlineViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class DeadlineViewController: BaseViewController {
    var selectedDate:String = ""
    
    private let mainView = DeadlineView()
    
    var deadLine:((String) -> Void)?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.picker.addTarget(self, action: #selector(setDate), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deadLine?(selectedDate)
    }

    @objc func setDate(_ sender: UIDatePicker){
        selectedDate = dateFormat(date: sender.date)
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        return formatter.string(from: date)
    }

}

