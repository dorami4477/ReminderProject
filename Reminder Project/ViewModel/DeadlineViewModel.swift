//
//  DeadlineViewModel.swift
//  Reminder Project
//
//  Created by 박다현 on 7/9/24.
//

import Foundation

class DeadlineViewModel{
    var inputDate = Observable(Date())
    var outputDate = Observable(GetDate.shared.dateToInt(date: Date()))
    
    
    init() {
        inputDate.bind { _ in
            self.selectedDate()
        }
    }
    
    func selectedDate(){
        let date = GetDate.shared.dateToInt(date: inputDate.value)
        outputDate.value = date
    }
}
