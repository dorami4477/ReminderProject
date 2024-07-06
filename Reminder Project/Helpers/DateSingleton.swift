//
//  DateExtension.swift
//  Reminder Project
//
//  Created by 박다현 on 7/5/24.
//

import Foundation


final class GetDate{
    
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
    
    func getToday() -> String{
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyy. MM. dd"
            let savedDateString = myFormatter.string(from: Date())
            return savedDateString
    }
    
    func dateToInt(date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return Int(formatter.string(from: date)) ?? 0
    }
    
    func toDate(date:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let date = dateFormatter.date(from: date) {
            return date
        } else {
            return nil
        }
    }
}
