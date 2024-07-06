//
//  CalendarViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/5/24.
//

import UIKit
import FSCalendar

final class CalendarViewController: BaseViewController{

    private let repository = TodoRepository()
    private let calendar = FSCalendar(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
    }
    
    override func configureHierarchy(){
        view.addSubview(calendar)
    }
    override func configureLayout(){
        calendar.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    override func configureView() {
        title = "캘린더"
        view.backgroundColor = .black
    }

    private func configureCalendar(){
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.weekdayTextColor = .white
        calendar.appearance.titleWeekendColor = AppColor.blue
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansCJKKR-Medium", size: 16)
        calendar.appearance.titleFont = UIFont(name: "Roboto-Regular", size: 14)
    }

}

// MARK: - calendar
extension CalendarViewController:FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let selectedDate = Int(formatter.string(from: date))
        
        let vc = ListViewController()
        vc.folderInfo["date"] = selectedDate
        vc.list = repository.setFolderData(5, date: selectedDate)
        navigationController?.pushViewController(vc, animated: true)
    }
}
