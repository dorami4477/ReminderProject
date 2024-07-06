//
//  CalendarViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/5/24.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController{

    let repository = TodoRepository()
    private let calendar = FSCalendar(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        calendarStyle()
    }
    private func configureHierarchy(){
        view.addSubview(calendar)
    }
    private func configureLayout(){
        calendar.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    private func configureUI(){
        calendar.delegate = self
        calendar.dataSource = self
        //view.backgroundColor = .white
        title = "캘린더"
    }
    func calendarStyle(){

        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.weekdayTextColor = .white //요일(월,화,수..) 글씨 색
        calendar.appearance.titleWeekendColor = .blue //주말 날짜 색
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.headerTitleFont = UIFont(name: "NotoSansCJKKR-Medium", size: 16)
        calendar.appearance.titleFont = UIFont(name: "Roboto-Regular", size: 14)
    }

}


extension CalendarViewController:FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let selectedDate = Int(formatter.string(from: date))
        
        let vc = ListViewController()
        vc.list = repository.setFolderData(5, date: selectedDate)
        navigationController?.pushViewController(vc, animated: true)
    }
}
