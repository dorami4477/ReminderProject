//
//  DateExtension.swift
//  Reminder Project
//
//  Created by 박다현 on 7/5/24.
//

import Foundation


final class GetDate{
    
    static let shared = GetDate()
    static let fomatter = DateFormatter()
    private let myFormatter = GetDate.fomatter
    private init(){}
    
    var todayInt:Int {
        myFormatter.dateFormat = "yyyyMMdd"
        let dateString = myFormatter.string(from: Date())
        return Int(dateString) ?? 0
    }
    
    func dateToString(_ intDate:Int) -> String{
        let date = String(intDate)
        let stringFormat = "yyyyMMdd"
        myFormatter.dateFormat = stringFormat
        myFormatter.locale = Locale(identifier: "ko")
        guard let tempDate = myFormatter.date(from: date) else {
            return ""
        }
        myFormatter.dateFormat = "yyyy. MM. dd"
        return myFormatter.string(from: tempDate)
    }
    
    func getToday() -> String{
            myFormatter.dateFormat = "yyyy. MM. dd"
            let savedDateString = myFormatter.string(from: Date())
            return savedDateString
    }
    
    func dateToInt(date: Date) -> Int {
        myFormatter.dateFormat = "yyyyMMdd"
        return Int(myFormatter.string(from: date)) ?? 0
    }
    
    func toDate(date:String) -> Date? {
        myFormatter.dateFormat = "yyyyMMdd"
        if let date = myFormatter.date(from: date) {
            return date
        } else {
            return nil
        }
    }
}
