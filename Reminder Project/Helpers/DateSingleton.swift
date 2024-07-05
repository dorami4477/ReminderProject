//
//  DateExtension.swift
//  Reminder Project
//
//  Created by 박다현 on 7/5/24.
//

import Foundation


class GetDate{
    
    static let shared = GetDate()
    private init(){}
    
    var todayInt:Int {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyyMMdd"
        let dateString = myFormatter.string(from: Date())
        return Int(dateString) ?? 0
    }
    
    func dateToString(_ intDate:Int) -> String{
        let date = String(intDate)
        let stringFormat = "yyyyMMdd"
        let formatter = DateFormatter()
        formatter.dateFormat = stringFormat
        formatter.locale = Locale(identifier: "ko")
        guard let tempDate = formatter.date(from: date) else {
            return ""
        }
        formatter.dateFormat = "yyyy. MM. dd"
        
        return formatter.string(from: tempDate)
    }
}
