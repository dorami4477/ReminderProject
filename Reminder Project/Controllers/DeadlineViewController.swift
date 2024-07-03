//
//  DeadlineViewController.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

class DeadlineViewController: BaseViewController {
    let years = [2024, 2025, 2026, 2027, 2028]
    let months = [1,2,3,4,5,6,7,8,9,10,11,12]
    let days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25, 26, 27,28,29, 30, 31]
    
    var selectedYear:Int = 2024
    var selectedMonth:Int = 1
    var selectedDay:Int = 1
    
    private let mainView = DeadlineView()
    
    var deadLine:((String) -> Void)?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.picker.delegate = self
        mainView.picker.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deadLine?("\(selectedYear). \(selectedMonth). \(selectedDay)")
    }


}

extension DeadlineViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0:
            return 5
        case 1:
            return 12
        case 2:
            return 31
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(years[row])년"
        case 1:
            return "\(months[row])월"
        case 2:
            return "\(days[row])일"
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch component {
        case 0:
            selectedYear = years[row]
        case 1:
            selectedMonth = months[row]
        case 2:
            selectedDay = days[row]
        default:
            break
        }
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0:
            return NSAttributedString(string: "\(years[row])년", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 1:
            return NSAttributedString(string: "\(months[row])월", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 2:
            return NSAttributedString(string: "\(days[row])일", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        default:
            return NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    
}
